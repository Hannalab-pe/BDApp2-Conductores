import 'package:equatable/equatable.dart';

/// Clase abstracta para representar fallos en la aplicación
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// Fallos de servidor
class ServerFailure extends Failure {
  const ServerFailure([String message = 'Error del servidor']) : super(message);
}

// Fallos de caché
class CacheFailure extends Failure {
  const CacheFailure([String message = 'Error de caché local']) : super(message);
}

// Fallos de red
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Error de conexión a internet']) : super(message);
}

// Fallos de autenticación
class AuthFailure extends Failure {
  const AuthFailure([String message = 'Error de autenticación']) : super(message);
}

// Fallos de validación
class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

// Fallos de permisos
class PermissionFailure extends Failure {
  const PermissionFailure([String message = 'Permiso denegado']) : super(message);
}
