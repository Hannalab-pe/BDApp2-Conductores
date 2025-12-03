/// Constantes generales de la aplicación
class AppConstants {
  // Mensajes de error genéricos
  static const String errorGeneral = 'Ha ocurrido un error. Por favor, intente nuevamente.';
  static const String errorNetwork = 'Error de conexión. Verifique su conexión a internet.';
  static const String errorTimeout = 'La solicitud ha excedido el tiempo de espera.';
  static const String errorUnauthorized = 'Sesión expirada. Por favor, inicie sesión nuevamente.';

  // Mensajes de éxito
  static const String successLogin = 'Bienvenido';
  static const String successLogout = 'Sesión cerrada correctamente';

  // Textos de la interfaz
  static const String loginTitle = 'Betondecken Conductores';
  static const String loginSubtitle = 'Ingrese sus credenciales';

  // Permisos
  static const String permissionLocationDenied = 'Se requiere permiso de ubicación para usar esta función';
  static const String permissionLocationDeniedForever = 'Permiso de ubicación denegado permanentemente. Active los permisos desde la configuración.';
}
