/// Constantes de endpoints de API
class ApiConstants {
  // Auth endpoints
  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
  static const String refreshToken = '/api/auth/refresh';
  static const String validateToken = '/api/auth/validate';

  // Driver endpoints
  static const String driverProfile = '/api/drivers/profile';
  static const String activeTrips = '/api/drivers/trips/active';
  static const String tripHistory = '/api/drivers/trips/history';
  static const String startTrip = '/api/drivers/trips/start';
  static const String completeTrip = '/api/drivers/trips/complete';

  // Delivery endpoints
  static const String deliveries = '/api/deliveries';
  static const String completeDelivery = '/api/deliveries/complete';
  static const String confirmDelivery = '/api/deliveries/confirm';

  // Tracking endpoints
  static const String updateLocation = '/api/tracking/location';
  static const String trackingHistory = '/api/tracking/history';

  // Headers
  static const String contentType = 'Content-Type';
  static const String authorization = 'Authorization';
  static const String applicationJson = 'application/json';
  static const String bearerPrefix = 'Bearer ';
}
