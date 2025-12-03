import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

/// Estados de autenticación
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Verificando autenticación
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Usuario autenticado exitosamente
class AuthAuthenticated extends AuthState {
  final User user;
  final String token;

  const AuthAuthenticated({
    required this.user,
    required this.token,
  });

  @override
  List<Object?> get props => [user, token];
}

/// Usuario no autenticado
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Error en autenticación
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
