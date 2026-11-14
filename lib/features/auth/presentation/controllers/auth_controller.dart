import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_profile_model.dart';

class AuthState {
  final UserProfileModel currentUser;
  final List<UserProfileModel> users;
  final String? errorMessage;

  const AuthState({
    required this.currentUser,
    required this.users,
    this.errorMessage,
  });

  AuthState copyWith({
    UserProfileModel? currentUser,
    List<UserProfileModel>? users,
    String? errorMessage,
  }) {
    return AuthState(
      currentUser: currentUser ?? this.currentUser,
      users: users ?? this.users,
      errorMessage: errorMessage,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier()
      : super(
          AuthState(
            currentUser: const UserProfileModel(
              id: 'f0000000-0000-4000-8000-000000000001',
              fullName: 'Mauricio (Admin)',
              role: 'admin',
              quickPin: '1234',
              email: 'admin@azulito.pos',
              storeId: 'a0000000-0000-4000-8000-000000000001',
            ),
            users: const [
              UserProfileModel(
                id: 'f0000000-0000-4000-8000-000000000001',
                fullName: 'Mauricio (Admin)',
                role: 'admin',
                quickPin: '1234',
                email: 'admin@azulito.pos',
                storeId: 'a0000000-0000-4000-8000-000000000001',
              ),
              UserProfileModel(
                id: 'f0000000-0000-4000-8000-000000000002',
                fullName: 'Cajero: Turno Mañana',
                role: 'cashier',
                quickPin: '0000',
                email: 'cajero@azulito.pos',
                storeId: 'a0000000-0000-4000-8000-000000000001',
              ),
            ],
          ),
        );

  /// Cambia el usuario activo si el PIN de 4 dígitos es correcto
  bool switchUser(String targetUserId, String enteredPin) {
    final target = state.users.firstWhere(
      (u) => u.id == targetUserId,
      orElse: () => state.currentUser,
    );

    if (target.quickPin == enteredPin) {
      state = state.copyWith(currentUser: target, errorMessage: null);
      return true;
    } else {
      state = state.copyWith(errorMessage: 'PIN incorrecto. Intente nuevamente.');
      return false;
    }
  }

  /// Verifica si el PIN ingresado corresponde a un usuario con rol 'admin'
  bool verifySupervisorPin(String pin) {
    final isAdminPin = state.users.any((u) => u.isAdmin && u.quickPin == pin);
    return isAdminPin;
  }

  /// Agrega o actualiza un usuario en la lista
  void saveUser(UserProfileModel user) {
    final exists = state.users.any((u) => u.id == user.id);
    List<UserProfileModel> updated;
    if (exists) {
      updated = state.users.map((u) => u.id == user.id ? user : u).toList();
    } else {
      updated = [...state.users, user];
    }
    state = state.copyWith(
      users: updated,
      currentUser: state.currentUser.id == user.id ? user : state.currentUser,
    );
  }
}

