import 'package:dio/dio.dart';
import '../../../../core/network/api_config.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

/// Interfaz para el datasource remoto de autenticación
abstract class AuthRemoteDataSource {
  /// Login con email y contraseña
  Future<Map<String, dynamic>> login(String email, String password);

  /// Logout
  Future<void> logout();

  /// Refresh token
  Future<String> refreshToken(String refreshToken);
}

/// Implementación del datasource remoto de autenticación
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dioClient.post(
        ApiConfig.loginEndpoint,
        data: {
          'correo': email,
          'contrasena': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        // Verificar que la respuesta contenga los datos necesarios
        if (data == null) {
          throw Exception('La respuesta del servidor está vacía');
        }

        // La API devuelve: { user: {...}, access_token: "..." }
        if (!data.containsKey('user') || !data.containsKey('access_token')) {
          throw Exception('Formato de respuesta inválido');
        }

        // Obtener datos del usuario
        final userData = data['user'] as Map<String, dynamic>;
        final userRole = userData['rol'] as String?;

        // Validar que sea un conductor
        if (userRole == null || userRole.toLowerCase() != 'conductor') {
          throw Exception(
            'Acceso denegado. Esta aplicación es solo para conductores.',
          );
        }

        // Actualizar el token en el cliente HTTP
        final token = data['access_token'] as String;
        dioClient.updateAuthToken(token);

        return {
          'user': userData,
          'token': token,
        };
      } else {
        throw Exception('Error en el login: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Manejar diferentes tipos de errores de Dio
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final errorData = e.response!.data;

        switch (statusCode) {
          case 400:
            throw Exception(
              errorData['message'] ?? 'Credenciales inválidas',
            );
          case 401:
            throw Exception(
              errorData['message'] ?? 'Email o contraseña incorrectos',
            );
          case 403:
            throw Exception(
              errorData['message'] ??
                  'Usuario inactivo o cuenta bloqueada por múltiples intentos fallidos',
            );
          case 404:
            throw Exception(
              errorData['message'] ?? 'Usuario no encontrado',
            );
          case 500:
            throw Exception(
              'Error interno del servidor. Intenta nuevamente más tarde.',
            );
          default:
            throw Exception(
              errorData['message'] ?? 'Error desconocido: $statusCode',
            );
        }
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
          'Tiempo de espera agotado. Verifica tu conexión a internet.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception(
          'No se pudo conectar al servidor. Verifica tu conexión a internet.',
        );
      } else {
        throw Exception('Error de red: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dioClient.post(ApiConfig.logoutEndpoint);
      dioClient.removeAuthToken();
    } on DioException catch (e) {
      // Incluso si el logout falla en el servidor, removemos el token local
      dioClient.removeAuthToken();
      throw Exception('Error al cerrar sesión: ${e.message}');
    }
  }

  @override
  Future<String> refreshToken(String refreshToken) async {
    try {
      final response = await dioClient.post(
        ApiConfig.refreshTokenEndpoint,
        data: {
          'refreshToken': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final newToken = response.data['token'] as String;
        dioClient.updateAuthToken(newToken);
        return newToken;
      } else {
        throw Exception('Error al renovar token: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error al renovar token: ${e.message}');
    }
  }
}
