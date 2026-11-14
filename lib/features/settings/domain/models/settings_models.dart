class StoreSettingsModel {
  final String id;
  final String name;
  final String rif;
  final String phone;
  final String address;
  final String ticketFooter;
  final String primaryColorHex;
  final String secondaryColorHex;
  final bool defaultIgtfEnabled;
  final double igtfPercentage;
  final String paperWidth; // '58mm' | '80mm'
  final String connectionType; // 'browser_pdf' | 'usb_desktop' | 'bluetooth'
  final bool autoPrintReceipt;

  const StoreSettingsModel({
    required this.id,
    required this.name,
    required this.rif,
    required this.phone,
    required this.address,
    required this.ticketFooter,
    required this.primaryColorHex,
    required this.secondaryColorHex,
    this.defaultIgtfEnabled = true,
    this.igtfPercentage = 3.0,
    this.paperWidth = '80mm',
    this.connectionType = 'browser_pdf',
    this.autoPrintReceipt = true,
  });

  StoreSettingsModel copyWith({
    String? id,
    String? name,
    String? rif,
    String? phone,
    String? address,
    String? ticketFooter,
    String? primaryColorHex,
    String? secondaryColorHex,
    bool? defaultIgtfEnabled,
    double? igtfPercentage,
    String? paperWidth,
    String? connectionType,
    bool? autoPrintReceipt,
  }) {
    return StoreSettingsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      rif: rif ?? this.rif,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      ticketFooter: ticketFooter ?? this.ticketFooter,
      primaryColorHex: primaryColorHex ?? this.primaryColorHex,
      secondaryColorHex: secondaryColorHex ?? this.secondaryColorHex,
      defaultIgtfEnabled: defaultIgtfEnabled ?? this.defaultIgtfEnabled,
      igtfPercentage: igtfPercentage ?? this.igtfPercentage,
      paperWidth: paperWidth ?? this.paperWidth,
      connectionType: connectionType ?? this.connectionType,
      autoPrintReceipt: autoPrintReceipt ?? this.autoPrintReceipt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rif': rif,
      'phone': phone,
      'address': address,
      'primary_color': primaryColorHex,
      'secondary_color': secondaryColorHex,
      'default_igtf_enabled': defaultIgtfEnabled,
    };
  }

  factory StoreSettingsModel.fromJson(Map<String, dynamic> json) {
    return StoreSettingsModel(
      id: json['id'] as String? ?? 'a0000000-0000-4000-8000-000000000001',
      name: json['name'] as String? ?? 'Azulito Market & POS',
      rif: json['rif'] as String? ?? 'J-50123456-7',
      phone: json['phone'] as String? ?? '+58 412 1234567',
      address: json['address'] as String? ?? 'Av. Principal con Calle 4, Caracas, Venezuela',
      ticketFooter: json['ticket_footer'] as String? ?? '¡Gracias por su compra en Azulito POS! Vuelva pronto.',
      primaryColorHex: json['primary_color'] as String? ?? '#1E40AF',
      secondaryColorHex: json['secondary_color'] as String? ?? '#0EA5E9',
      defaultIgtfEnabled: json['default_igtf_enabled'] as bool? ?? true,
      igtfPercentage: 3.0,
      paperWidth: '80mm',
      connectionType: 'browser_pdf',
      autoPrintReceipt: true,
    );
  }
}

class ColorPalettePreset {
  final String id;
  final String name;
  final String primaryHex;
  final String secondaryHex;
  final String tag;

  const ColorPalettePreset({
    required this.id,
    required this.name,
    required this.primaryHex,
    required this.secondaryHex,
    required this.tag,
  });
}
