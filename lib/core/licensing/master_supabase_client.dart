import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'license_model.dart';

/// Configuración fija del Servidor Maestro de Licencias SaaS
const String kMasterSupabaseUrl = 'https://ujrwamckhqhhtdfbikhy.supabase.co';
const String kMasterSupabaseAnonKey = 'sb_publishable_OamTK90V9yFUb4Yzs74NsA_7_T-v1bb';

/// Instancia dedicada del cliente Supabase para el Servidor Maestro
final masterSupabaseClient = SupabaseClient(
  kMasterSupabaseUrl,
  kMasterSupabaseAnonKey,
);

class MasterLicensingService {
  final SupabaseClient _client;

  MasterLicensingService([SupabaseClient? client])
      : _client = client ?? masterSupabaseClient;

  /// Valida el código de tienda y PIN en el servidor maestro
  Future<BusinessLicenseModel?> validateLicense({
    required String storeCode,
    required String pin,
  }) async {
    try {
      final res = await _client
          .from('licencias_negocios')
          .select()
          .eq('codigo_tienda', storeCode.trim().toUpperCase())
          .eq('pin_activacion', pin.trim())
          .maybeSingle();

      if (res != null) {
        return BusinessLicenseModel.fromJson(res);
      }
      return null;
    } catch (e) {
      debugPrint('[MasterLicensingService] Error al validar licencia: $e');
      return null;
    }
  }

  /// Obtiene la lista completa de licencias para la consola SuperAdmin
  Future<List<BusinessLicenseModel>> getAllLicenses() async {
    try {
      final res = await _client
          .from('licencias_negocios')
          .select()
          .order('codigo_tienda', ascending: true);

      return (res as List)
          .map((item) => BusinessLicenseModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('[MasterLicensingService] Error al listar licencias: $e');
      return [];
    }
  }

  /// Actualiza el estado de una licencia (Kill-Switch en tiempo real)
  Future<bool> updateLicenseStatus({
    required String storeCode,
    required String newStatus,
  }) async {
    try {
      await _client
          .from('licencias_negocios')
          .update({
            'estado_licencia': newStatus,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('codigo_tienda', storeCode.trim().toUpperCase());
      return true;
    } catch (e) {
      debugPrint('[MasterLicensingService] Error al actualizar estado de licencia: $e');
      return false;
    }
  }

  /// Registra o actualiza un negocio nuevo o existente
  Future<bool> upsertLicense(BusinessLicenseModel license) async {
    try {
      final payload = {
        'codigo_tienda': license.storeCode.trim().toUpperCase(),
        'pin_activacion': license.activationPin.trim(),
        'nombre_negocio': license.businessName.trim(),
        'rif_negocio': license.rif?.trim(),
        'target_supabase_url': license.targetSupabaseUrl.trim(),
        'target_supabase_anon_key': license.targetSupabaseAnonKey.trim(),
        'plan_suscripcion': license.plan,
        'estado_licencia': license.status,
        'notas_soporte': license.supportNotes,
        'updated_at': DateTime.now().toIso8601String(),
      };

      await _client
          .from('licencias_negocios')
          .upsert(payload, onConflict: 'codigo_tienda');
      return true;
    } catch (e) {
      debugPrint('[MasterLicensingService] Error al guardar negocio: $e');
      return false;
    }
  }
}
