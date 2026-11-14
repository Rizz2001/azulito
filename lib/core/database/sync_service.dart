import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../licensing/master_supabase_client.dart';
import 'tenant_supabase_client.dart';

// Estado del Motor de Sincronización y Simulador Anti-Apagones
class SyncState {
  final bool isOfflineSimulated;
  final int pendingCount;
  final List<Map<String, dynamic>> localQueue;

  const SyncState({
    this.isOfflineSimulated = false,
    this.pendingCount = 0,
    this.localQueue = const [],
  });

  bool get isOnline => !isOfflineSimulated;

  String get statusBadgeLabel {
    if (isOfflineSimulated) {
      return pendingCount > 0
          ? 'Modo Offline ($pendingCount en cola)'
          : 'Modo Offline (Sin Internet)';
    }
    return 'Online - Sincronizado';
  }

  SyncState copyWith({
    bool? isOfflineSimulated,
    int? pendingCount,
    List<Map<String, dynamic>>? localQueue,
  }) {
    return SyncState(
      isOfflineSimulated: isOfflineSimulated ?? this.isOfflineSimulated,
      pendingCount: pendingCount ?? this.pendingCount,
      localQueue: localQueue ?? this.localQueue,
    );
  }
}

class SyncNotifier extends StateNotifier<SyncState> {
  static const _uuid = Uuid();
  final Ref? _ref;

  SyncNotifier([this._ref]) : super(const SyncState());

  /// Alterna el simulador de apagón / corte de internet
  void toggleOfflineSimulation() {
    final nextState = !state.isOfflineSimulated;
    state = state.copyWith(isOfflineSimulated: nextState);

    // Si volvemos a pasar a Online, ejecutamos flush automático de la cola
    if (!nextState && state.pendingCount > 0) {
      flushQueue();
    }
  }

  /// Registra una operación en la cola de sincronización
  void enqueueOperation({
    required String targetTable,
    required String entityId,
    required String operation, // 'INSERT', 'UPDATE', 'DELETE'
    required Map<String, dynamic> payload,
  }) {
    final newEntry = {
      'id': _uuid.v4(),
      'targetTable': targetTable,
      'entityId': entityId,
      'operation': operation,
      'payload': payload,
      'createdAt': DateTime.now().toIso8601String(),
    };

    if (state.isOfflineSimulated) {
      // En modo offline, acumula en cola
      final updatedQueue = [...state.localQueue, newEntry];
      state = state.copyWith(
        localQueue: updatedQueue,
        pendingCount: updatedQueue.length,
      );
    } else {
      // En modo online, sincroniza de inmediato con Supabase en background
      _syncItemToSupabase(newEntry);
    }
  }

  /// Procesa y vacía la cola acumulada durante el modo offline
  Future<void> flushQueue() async {
    final itemsToSync = List<Map<String, dynamic>>.from(state.localQueue);
    for (final item in itemsToSync) {
      await _syncItemToSupabase(item);
    }
    state = state.copyWith(
      localQueue: const [],
      pendingCount: 0,
    );
  }

  Future<void> _syncItemToSupabase(Map<String, dynamic> item) async {
    try {
      final client = _ref != null 
          ? _ref.read(tenantSupabaseClientProvider)
          : (Supabase.instance.isInitialized ? Supabase.instance.client : masterSupabaseClient);

      final table = item['targetTable'] as String;
      final op = item['operation'] as String;
      final payload = item['payload'] as Map<String, dynamic>;

      if (op == 'INSERT') {
        await client.from(table).insert(payload);
      } else if (op == 'UPDATE') {
        await client.from(table).update(payload).eq('id', item['entityId']);
      } else if (op == 'DELETE') {
        await client.from(table).delete().eq('id', item['entityId']);
      }
    } catch (e) {
      debugPrint('[SyncService] Fallback offline: $e');
    }
  }
}

final syncProvider = StateNotifierProvider<SyncNotifier, SyncState>((ref) {
  return SyncNotifier(ref);
});
