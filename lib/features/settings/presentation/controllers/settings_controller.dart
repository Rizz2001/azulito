import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/database/sync_service.dart';
import '../../domain/models/settings_models.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, StoreSettingsModel>((ref) {
  return SettingsNotifier(ref);
});

class SettingsNotifier extends StateNotifier<StoreSettingsModel> {
  final Ref _ref;

  static const List<ColorPalettePreset> presets = [
    ColorPalettePreset(
      id: 'azulito_default',
      name: 'Azulito Royal (Default)',
      primaryHex: '#1E40AF',
      secondaryHex: '#0EA5E9',
      tag: 'Oficial',
    ),
    ColorPalettePreset(
      id: 'esmeralda_clapos',
      name: 'Esmeralda ClaPos',
      primaryHex: '#10B981',
      secondaryHex: '#059669',
      tag: 'Eco & Fresh',
    ),
    ColorPalettePreset(
      id: 'naranja_delivo',
      name: 'Naranja Delivo',
      primaryHex: '#F97316',
      secondaryHex: '#EA580C',
      tag: 'Comida & Envíos',
    ),
    ColorPalettePreset(
      id: 'violeta_premium',
      name: 'Violeta Premium',
      primaryHex: '#7C3AED',
      secondaryHex: '#6366F1',
      tag: 'Boutique & Retail',
    ),
    ColorPalettePreset(
      id: 'rosa_magenta',
      name: 'Rosa Magenta',
      primaryHex: '#EC4899',
      secondaryHex: '#BE185D',
      tag: 'Cosméticos & Moda',
    ),
    ColorPalettePreset(
      id: 'dark_titanium',
      name: 'Dark Titanium',
      primaryHex: '#0F172A',
      secondaryHex: '#334155',
      tag: 'Minimalista',
    ),
  ];

  SettingsNotifier(this._ref)
      : super(
          const StoreSettingsModel(
            id: 'a0000000-0000-4000-8000-000000000001',
            name: 'Azulito Market & POS',
            rif: 'J-50123456-7',
            phone: '+58 412 1234567',
            address: 'Av. Principal con Calle 4, Caracas, Venezuela',
            ticketFooter: '¡Gracias por su compra en Azulito POS! Vuelva pronto.',
            primaryColorHex: '#1E40AF',
            secondaryColorHex: '#0EA5E9',
            defaultIgtfEnabled: true,
            igtfPercentage: 3.0,
            paperWidth: '80mm',
            connectionType: 'browser_pdf',
            autoPrintReceipt: true,
          ),
        );

  /// Convierte String Hex `#1E40AF` a Color Flutter
  static Color hexToColor(String hex) {
    final clean = hex.replaceAll('#', '');
    if (clean.length == 6) {
      return Color(int.parse('FF$clean', radix: 16));
    }
    return AppColors.defaultPrimary;
  }

  /// Cambia la paleta de colores dinámicamente en toda la aplicación
  void applyPalette(ColorPalettePreset preset) {
    state = state.copyWith(
      primaryColorHex: preset.primaryHex,
      secondaryColorHex: preset.secondaryHex,
    );

    // Actualiza el tema global en tiempo real
    final newColor = hexToColor(preset.primaryHex);
    _ref.read(primaryColorProvider.notifier).updateColor(newColor);

    // Encola actualización en Supabase / Drift
    _ref.read(syncProvider.notifier).enqueueOperation(
      targetTable: 'stores',
      entityId: state.id,
      operation: 'UPDATE',
      payload: {
        'id': state.id,
        'primary_color': preset.primaryHex,
        'secondary_color': preset.secondaryHex,
      },
    );
  }

  /// Actualiza los datos fiscales y comerciales del negocio
  void updateStoreDetails({
    required String name,
    required String rif,
    required String phone,
    required String address,
    required String ticketFooter,
    required double igtfPercentage,
    required bool defaultIgtfEnabled,
  }) {
    state = state.copyWith(
      name: name,
      rif: rif,
      phone: phone,
      address: address,
      ticketFooter: ticketFooter,
      igtfPercentage: igtfPercentage,
      defaultIgtfEnabled: defaultIgtfEnabled,
    );

    _ref.read(syncProvider.notifier).enqueueOperation(
      targetTable: 'stores',
      entityId: state.id,
      operation: 'UPDATE',
      payload: {
        'id': state.id,
        'name': name,
        'rif': rif,
        'phone': phone,
        'address': address,
        'default_igtf_enabled': defaultIgtfEnabled,
      },
    );
  }

  /// Actualiza la configuración de la impresora térmica
  void updatePrinterSettings({
    required String paperWidth,
    required String connectionType,
    required bool autoPrintReceipt,
  }) {
    state = state.copyWith(
      paperWidth: paperWidth,
      connectionType: connectionType,
      autoPrintReceipt: autoPrintReceipt,
    );
  }
}

