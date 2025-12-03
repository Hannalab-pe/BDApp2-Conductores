/// Configuración global de la aplicación Betondecken Conductores
class AppConfig {
  static const String appName = 'Betondecken Conductores';
  static const String appVersion = '1.0.0';

  // Configuración del entorno
  static const bool isProduction = false;

  // URLs de API (ajustar según tu servidor)
  static const String baseUrl = isProduction
      ? 'https://api.betondecken.com'
      : 'https://dev-api.betondecken.com';

  // Timeouts
  static const int connectionTimeout = 30000; // 30 segundos
  static const int receiveTimeout = 30000;

  // Configuración de sesión
  static const Duration sessionTimeout = Duration(hours: 8);

  // Configuración de tracking GPS
  static const int locationUpdateInterval = 30000; // 30 segundos
  static const double minDistanceForUpdate = 10.0; // 10 metros
}
