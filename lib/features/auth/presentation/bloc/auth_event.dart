import 'package:equatable/equatable.dart';

/// Eventos de autenticación
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Evento: Usuario presiona botón de login
class LoginButtonPressed extends AuthEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// Evento: Verificar si hay sesión activa
class CheckAuthStatus extends AuthEvent {
  const CheckAuthStatus();
}

/// Evento: Cerrar sesión
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
