/// Excepción de servidor
class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Error del servidor']);
}

/// Excepción de caché
class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Error de caché']);
}

/// Excepción de red
class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = 'Sin conexión a internet']);
}

/// Excepción de autenticación
class AuthException implements Exception {
  final String message;
  AuthException([this.message = 'Error de autenticación']);
}

/// Excepción de validación
class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}
