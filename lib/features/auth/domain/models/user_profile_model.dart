class UserProfileModel {
  final String id;
  final String fullName;
  final String role; // 'admin' | 'cashier'
  final String quickPin; // 4 dígitos
  final String email;
  final String storeId;
  final bool isActive;

  const UserProfileModel({
    required this.id,
    required this.fullName,
    required this.role,
    required this.quickPin,
    required this.email,
    required this.storeId,
    this.isActive = true,
  });

  bool get isAdmin => role == 'admin';
  bool get isCashier => role == 'cashier';

  UserProfileModel copyWith({
    String? id,
    String? fullName,
    String? role,
    String? quickPin,
    String? email,
    String? storeId,
    bool? isActive,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      quickPin: quickPin ?? this.quickPin,
      email: email ?? this.email,
      storeId: storeId ?? this.storeId,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'role': role,
      'quick_pin': quickPin,
      'email': email,
      'store_id': storeId,
      'is_active': isActive,
    };
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      role: json['role'] as String? ?? 'cashier',
      quickPin: json['quick_pin'] as String? ?? '0000',
      email: json['email'] as String? ?? '',
      storeId: json['store_id'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
    );
  }
}

