import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';

/// Interfaz para el datasource remoto de despachos
abstract class DespachoRemoteDataSource {
  /// Obtener despachos asignados a un conductor
  Future<List<Map<String, dynamic>>> getDespachosByConductor(String idUsuario);
}

/// Implementación del datasource remoto de despachos
class DespachoRemoteDataSourceImpl implements DespachoRemoteDataSource {
  final DioClient dioClient;

  DespachoRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<Map<String, dynamic>>> getDespachosByConductor(
    String idUsuario,
  ) async {
    try {
      final response = await dioClient.get(
        '/asignacion-despacho-conductor/conductor/$idUsuario',
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Verificar que la respuesta contenga los datos necesarios
        if (data == null) {
          throw Exception('La respuesta del servidor está vacía');
        }

        // La API devuelve: { success: true, message: "...", data: [...] }
        if (!data.containsKey('data')) {
          throw Exception('Formato de respuesta inválido');
        }

        final despachos = data['data'] as List<dynamic>;

        // Convertir a List<Map<String, dynamic>>
        return despachos
            .map((despacho) => despacho as Map<String, dynamic>)
            .toList();
      } else {
        throw Exception('Error al obtener despachos: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Manejar diferentes tipos de errores de Dio
      if (e.response != null) {
        final statusCode = e.response!.statusCode;
        final errorData = e.response!.data;

        switch (statusCode) {
          case 404:
            throw Exception(
              errorData['message'] ?? 'No se encontraron despachos asignados',
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
}
