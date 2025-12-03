import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/models/user_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC de autenticación
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLocalDataSource? authLocalDataSource;
  final AuthRemoteDataSource? authRemoteDataSource;
  final bool useRemoteApi;

  AuthBloc({
    this.authLocalDataSource,
    this.authRemoteDataSource,
    this.useRemoteApi = false, // Por defecto usa local para desarrollo
  }) : super(const AuthInitial()) {
    // Validar que al menos uno de los datasources esté presente
    assert(
      authLocalDataSource != null || authRemoteDataSource != null,
      'Debe proporcionar al menos un datasource (local o remoto)',
    );

    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LogoutRequested>(_onLogoutRequested);
  }

  /// Verificar si hay sesión activa
  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(seconds: 2)); // Simular verificación

    // TODO: Implementar verificación real con SharedPreferences/Hive
    // Por ahora, asumimos no hay sesión
    emit(const AuthUnauthenticated());
  }

  /// Manejar intento de login
  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      // Validación básica
      if (event.email.isEmpty || event.password.isEmpty) {
        emit(const AuthError('Por favor complete todos los campos'));
        return;
      }

      // Usar API remota o local según configuración
      if (useRemoteApi && authRemoteDataSource != null) {
        // Login con API remota
        final response = await authRemoteDataSource!.login(
          event.email,
          event.password,
        );

        final userJson = response['user'] as Map<String, dynamic>;
        final user = UserModel.fromJson(userJson);
        final token = response['token'] as String;

        emit(AuthAuthenticated(
          user: user,
          token: token,
        ));
      } else if (authLocalDataSource != null) {
        // Login local (desarrollo)
        final user = await authLocalDataSource!.login(
          event.email,
          event.password,
        );

        emit(AuthAuthenticated(user: user, token: 'local_session_token'));
      } else {
        emit(const AuthError('No hay datasource configurado'));
      }
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  /// Cerrar sesión
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    // TODO: Limpiar tokens y datos locales
    await Future.delayed(const Duration(milliseconds: 500));

    emit(const AuthUnauthenticated());
  }
}
