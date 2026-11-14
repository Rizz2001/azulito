class BusinessLicenseModel {
  final String id;
  final String storeCode;
  final String activationPin;
  final String businessName;
  final String? rif;
  final String targetSupabaseUrl;
  final String targetSupabaseAnonKey;
  final String plan;
  final String status; // 'activa' | 'suspendida' | 'vencida'
  final DateTime? expirationDate;
  final int activeDevices;
  final String? supportNotes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BusinessLicenseModel({
    required this.id,
    required this.storeCode,
    required this.activationPin,
    required this.businessName,
    this.rif,
    required this.targetSupabaseUrl,
    required this.targetSupabaseAnonKey,
    this.plan = 'PRO_BIMONEDA',
    this.status = 'activa',
    this.expirationDate,
    this.activeDevices = 1,
    this.supportNotes,
    this.createdAt,
    this.updatedAt,
  });

  bool get isActive => status.toLowerCase() == 'activa';
  bool get isSuspended => status.toLowerCase() == 'suspendida';
  bool get isExpired => status.toLowerCase() == 'vencida';

  BusinessLicenseModel copyWith({
    String? id,
    String? storeCode,
    String? activationPin,
    String? businessName,
    String? rif,
    String? targetSupabaseUrl,
    String? targetSupabaseAnonKey,
    String? plan,
    String? status,
    DateTime? expirationDate,
    int? activeDevices,
    String? supportNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BusinessLicenseModel(
      id: id ?? this.id,
      storeCode: storeCode ?? this.storeCode,
      activationPin: activationPin ?? this.activationPin,
      businessName: businessName ?? this.businessName,
      rif: rif ?? this.rif,
      targetSupabaseUrl: targetSupabaseUrl ?? this.targetSupabaseUrl,
      targetSupabaseAnonKey: targetSupabaseAnonKey ?? this.targetSupabaseAnonKey,
      plan: plan ?? this.plan,
      status: status ?? this.status,
      expirationDate: expirationDate ?? this.expirationDate,
      activeDevices: activeDevices ?? this.activeDevices,
      supportNotes: supportNotes ?? this.supportNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo_tienda': storeCode,
      'pin_activacion': activationPin,
      'nombre_negocio': businessName,
      'rif_negocio': rif,
      'target_supabase_url': targetSupabaseUrl,
      'target_supabase_anon_key': targetSupabaseAnonKey,
      'plan_suscripcion': plan,
      'estado_licencia': status,
      'fecha_vencimiento': expirationDate?.toIso8601String(),
      'dispositivos_activos': activeDevices,
      'notas_soporte': supportNotes,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory BusinessLicenseModel.fromJson(Map<String, dynamic> json) {
    return BusinessLicenseModel(
      id: json['id'] as String? ?? '',
      storeCode: json['codigo_tienda'] as String? ?? '',
      activationPin: json['pin_activacion'] as String? ?? '',
      businessName: json['nombre_negocio'] as String? ?? 'Negocio Sin Nombre',
      rif: json['rif_negocio'] as String?,
      targetSupabaseUrl: json['target_supabase_url'] as String? ?? '',
      targetSupabaseAnonKey: json['target_supabase_anon_key'] as String? ?? '',
      plan: json['plan_suscripcion'] as String? ?? 'PRO_BIMONEDA',
      status: json['estado_licencia'] as String? ?? 'activa',
      expirationDate: json['fecha_vencimiento'] != null
          ? DateTime.tryParse(json['fecha_vencimiento'] as String)
          : null,
      activeDevices: json['dispositivos_activos'] as int? ?? 1,
      supportNotes: json['notas_soporte'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }
}
