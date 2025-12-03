import '../models/user_model.dart';

/// DataSource local para autenticación (credenciales hardcoded)
abstract class AuthLocalDataSource {
  /// Valida credenciales y retorna el usuario si son correctas
  Future<UserModel> login(String email, String password);

  /// Logout local
  Future<void> logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // Credenciales válidas hardcoded
  static const String _validEmail = 'conductor123@betondecken.com';
  static const String _validPassword = 'conductor123';

  // Usuario mock que se retorna al hacer login exitoso
  static final UserModel _mockUser = UserModel(
    id: 'COND-001',
    nombre: 'Juan Pérez',
    email: _validEmail,
    telefono: '+52 123 456 7890',
    rol: 'conductor',
    activo: true,
    foto: null, // Por ahora sin foto
  );

  @override
  Future<UserModel> login(String email, String password) async {
    // Simular delay de red (200ms)
    await Future.delayed(const Duration(milliseconds: 200));

    // Validar credenciales
    if (email.trim().toLowerCase() == _validEmail.toLowerCase() &&
        password == _validPassword) {
      // Credenciales correctas
      return _mockUser;
    } else {
      // Credenciales incorrectas
      throw Exception('Credenciales incorrectas. Verifica tu email y contraseña.');
    }
  }

  @override
  Future<void> logout() async {
    // Por ahora solo simular delay
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
