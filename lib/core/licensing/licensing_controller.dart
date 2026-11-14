import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/settings/presentation/controllers/settings_controller.dart';
import 'license_model.dart';
import 'master_supabase_client.dart';

class LicensingState {
  final BusinessLicenseModel? activeLicense;
  final List<BusinessLicenseModel> allLicenses;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuperAdminUnlocked;

  const LicensingState({
    this.activeLicense,
    this.allLicenses = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isSuperAdminUnlocked = false,
  });

  bool get hasActiveLicense => activeLicense != null && activeLicense!.isActive;
  bool get isSuspended => activeLicense != null && activeLicense!.isSuspended;

  LicensingState copyWith({
    BusinessLicenseModel? activeLicense,
    List<BusinessLicenseModel>? allLicenses,
    bool? isLoading,
    String? errorMessage,
    bool? isSuperAdminUnlocked,
  }) {
    return LicensingState(
      activeLicense: activeLicense ?? this.activeLicense,
      allLicenses: allLicenses ?? this.allLicenses,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuperAdminUnlocked: isSuperAdminUnlocked ?? this.isSuperAdminUnlocked,
    );
  }
}

final licensingProvider = StateNotifierProvider<LicensingNotifier, LicensingState>((ref) {
  return LicensingNotifier(ref);
});

class LicensingNotifier extends StateNotifier<LicensingState> {
  final Ref _ref;
  final MasterLicensingService _service;

  // Semilla por defecto: Bodegón Principal Activo
  static const BusinessLicenseModel defaultLicense = BusinessLicenseModel(
    id: 'l0000000-0000-4000-8000-000000000001',
    storeCode: 'AZUL-BODEGON-01',
    activationPin: '8842',
    businessName: 'Azulito Market & POS (Principal)',
    rif: 'J-50123456-7',
    targetSupabaseUrl: kMasterSupabaseUrl,
    targetSupabaseAnonKey: kMasterSupabaseAnonKey,
    plan: 'PRO_BIMONEDA',
    status: 'activa',
    supportNotes: 'Servidor de producción principal con datos en vivo',
  );

  LicensingNotifier(this._ref, [MasterLicensingService? service])
      : _service = service ?? MasterLicensingService(),
        super(
          const LicensingState(
            activeLicense: defaultLicense,
            allLicenses: [defaultLicense],
          ),
        ) {
    // Carga inicial en segundo plano de las licencias del servidor maestro
    refreshLicensesList();
  }

  /// Consulta el servidor maestro y actualiza la lista de licencias
  Future<void> refreshLicensesList() async {
    try {
      final list = await _service.getAllLicenses();
      if (list.isNotEmpty) {
        // Actualiza también el estado de la licencia activa si cambió remotamente
        BusinessLicenseModel? updatedActive = state.activeLicense;
        if (state.activeLicense != null) {
          final matched = list.firstWhere(
            (l) => l.storeCode.toUpperCase() == state.activeLicense!.storeCode.toUpperCase(),
            orElse: () => state.activeLicense!,
          );
          updatedActive = matched;
        }

        state = state.copyWith(
          allLicenses: list,
          activeLicense: updatedActive,
        );
      }
    } catch (_) {}
  }

  /// Vincula el terminal a un negocio validando en el Servidor Maestro
  Future<bool> activateTerminal({
    required String storeCode,
    required String pin,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final license = await _service.validateLicense(storeCode: storeCode, pin: pin);

      if (license == null) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Código de tienda o PIN inválido. Verifique los datos.',
        );
        return false;
      }

      // Si la licencia existe (aunque esté suspendida), se guarda para reflejar el estado
      state = state.copyWith(
        activeLicense: license,
        isLoading: false,
        errorMessage: null,
      );

      // Si está activa, sincroniza el nombre y RIF del negocio en la configuración general
      if (license.isActive) {
        final currentSettings = _ref.read(settingsProvider);
        _ref.read(settingsProvider.notifier).updateStoreDetails(
              name: license.businessName,
              rif: license.rif ?? currentSettings.rif,
              phone: currentSettings.phone,
              address: currentSettings.address,
              ticketFooter: currentSettings.ticketFooter,
              igtfPercentage: currentSettings.igtfPercentage,
              defaultIgtfEnabled: currentSettings.defaultIgtfEnabled,
            );
      }

      await refreshLicensesList();
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error de conexión con el Servidor Maestro: $e',
      );
      return false;
    }
  }

  /// Activa o suspende una tienda en tiempo real (Kill-Switch) desde la Consola SuperAdmin
  Future<bool> toggleStoreStatus(String storeCode, String newStatus) async {
    final success = await _service.updateLicenseStatus(storeCode: storeCode, newStatus: newStatus);
    if (success) {
      await refreshLicensesList();
      return true;
    }
    return false;
  }

  /// Registra o edita una tienda con sus credenciales propias de Supabase
  Future<bool> saveCustomBusiness(BusinessLicenseModel license) async {
    final success = await _service.upsertLicense(license);
    if (success) {
      await refreshLicensesList();
      return true;
    }
    return false;
  }

  /// Valida el PIN de SuperAdmin (9999) para desbloquear la Consola Maestro
  bool unlockSuperAdmin(String pin) {
    if (pin.trim() == '9999') {
      state = state.copyWith(isSuperAdminUnlocked: true);
      return true;
    }
    return false;
  }

  /// Cierra la sesión de la consola SuperAdmin
  void lockSuperAdmin() {
    state = state.copyWith(isSuperAdminUnlocked: false);
  }

  /// Desvincula la tienda actual para volver a ingresar otro código de activación
  void deactivateTerminal() {
    state = state.copyWith(activeLicense: null);
  }
}
