/// Configuración de entorno de la aplicación
class EnvConfig {
  // Cambiar a true cuando tengas la URL de la API real
  static const bool useRemoteApi = true; // ✅ Activado para usar API real

  // URL base de la API
  // Usar 10.0.2.2 en emulador Android para apuntar a localhost de la PC
  static const String apiBaseUrl = 'http://10.0.2.2:3002';

  // Ambiente actual
  static const String environment = 'development'; // development, staging, production

  // Debug mode
  static const bool debugMode = true;
}
