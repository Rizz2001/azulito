import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../licensing/licensing_controller.dart';
import '../licensing/master_supabase_client.dart';

/// Provider reactivo que devuelve el cliente Supabase del negocio activo.
/// Si la tienda activa es la principal o no tiene credenciales personalizadas,
/// utiliza la conexión predeterminada del servidor maestro.
final tenantSupabaseClientProvider = Provider<SupabaseClient>((ref) {
  final licensingState = ref.watch(licensingProvider);
  final activeLicense = licensingState.activeLicense;

  if (activeLicense != null &&
      activeLicense.targetSupabaseUrl.isNotEmpty &&
      activeLicense.targetSupabaseAnonKey.isNotEmpty) {
    // Si la URL es la misma del maestro, reutiliza la instancia del cliente maestro
    if (activeLicense.targetSupabaseUrl == kMasterSupabaseUrl &&
        activeLicense.targetSupabaseAnonKey == kMasterSupabaseAnonKey) {
      return masterSupabaseClient;
    }

    // Instancia dinámica e independiente para el Supabase propio del cliente
    return SupabaseClient(
      activeLicense.targetSupabaseUrl,
      activeLicense.targetSupabaseAnonKey,
    );
  }

  // Fallback por defecto al cliente maestro
  return masterSupabaseClient;
});
