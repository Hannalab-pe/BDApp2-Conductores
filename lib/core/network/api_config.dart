import '../config/env_config.dart';

/// Configuración de la API de Betondecken
class ApiConfig {
  // Base URL de la API (viene de env_config.dart)
  static String get baseUrl => EnvConfig.apiBaseUrl;

  // Versión de la API
  static const String apiVersion = 'v1';

  // URL completa
  static String get apiBaseUrl => '$baseUrl/api/$apiVersion';

  // Endpoints de autenticación
  static const String loginEndpoint = '/auth/login';
  static const String logoutEndpoint = '/auth/logout';
  static const String refreshTokenEndpoint = '/auth/refresh';

  // Endpoints de conductores
  static const String driverProfileEndpoint = '/conductores/perfil';
  static const String driverDespachosEndpoint = '/conductores/despachos';
  static const String driverAvisosEndpoint = '/conductores/avisos';

  // Configuración de timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Headers por defecto
  static Map<String, String> get defaultHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}
