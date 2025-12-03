import 'package:flutter/material.dart';
import '../../../../core/config/theme_config.dart';
import '../../../auth/domain/entities/user.dart';

/// Sección de Avisos
class AvisosSection extends StatelessWidget {
  final User user;

  const AvisosSection({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: Column(
        children: [
          // Header
          _buildHeader(),

          // Lista de avisos
          Expanded(
            child: _buildAvisosList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFFAFAFA),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Avisos y Notificaciones',
            style: TextStyle(
              color: ThemeConfig.negro,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mantente informado sobre actualizaciones importantes',
            style: TextStyle(
              color: ThemeConfig.gris,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvisosList() {
    // Datos mock de avisos
    final avisos = [
      {
        'id': '1',
        'tipo': 'urgente',
        'titulo': 'Cambio de horario - DSP-002',
        'mensaje':
            'El despacho DSP-002 se ha reprogramado para las 2:00 PM. Por favor confirma tu disponibilidad.',
        'fecha': 'Hace 30 min',
        'leido': false,
      },
      {
        'id': '2',
        'tipo': 'info',
        'titulo': 'Nueva ruta disponible',
        'mensaje':
            'Se ha optimizado la ruta para el despacho DSP-001. Revisa el mapa actualizado.',
        'fecha': 'Hace 1 hora',
        'leido': false,
      },
      {
        'id': '3',
        'tipo': 'importante',
        'titulo': 'Documentación requerida',
        'mensaje':
            'Recuerda llevar la documentación completa para la entrega en Constructora ABC.',
        'fecha': 'Hace 2 horas',
        'leido': true,
      },
      {
        'id': '4',
        'tipo': 'info',
        'titulo': 'Mantenimiento de sistema',
        'mensaje':
            'El sistema estará en mantenimiento el domingo de 2:00 AM a 6:00 AM.',
        'fecha': 'Ayer',
        'leido': true,
      },
      {
        'id': '5',
        'tipo': 'felicitacion',
        'titulo': '¡Excelente trabajo!',
        'mensaje':
            'Has completado 15 entregas exitosas este mes. ¡Sigue así!',
        'fecha': 'Hace 2 días',
        'leido': true,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: avisos.length,
      itemBuilder: (context, index) {
        final aviso = avisos[index];
        return _buildAvisoCard(aviso);
      },
    );
  }

  Widget _buildAvisoCard(Map<String, dynamic> aviso) {
    Color typeColor;
    IconData typeIcon;
    String tipo = aviso['tipo'] as String;

    switch (tipo) {
      case 'urgente':
        typeColor = ThemeConfig.rojo;
        typeIcon = Icons.warning_amber_rounded;
        break;
      case 'importante':
        typeColor = ThemeConfig.mostaza;
        typeIcon = Icons.info_outline;
        break;
      case 'felicitacion':
        typeColor = Colors.green;
        typeIcon = Icons.celebration_outlined;
        break;
      default:
        typeColor = Colors.blue;
        typeIcon = Icons.notifications_outlined;
    }

    final bool leido = aviso['leido'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: leido
              ? Colors.grey.withValues(alpha: 0.2)
              : typeColor.withValues(alpha: 0.4),
          width: leido ? 1 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // TODO: Marcar como leído y mostrar detalle
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icono del tipo de aviso
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: typeColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    typeIcon,
                    color: typeColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // Contenido del aviso
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              aviso['titulo'] as String,
                              style: TextStyle(
                                color: ThemeConfig.negro,
                                fontSize: 16,
                                fontWeight:
                                    leido ? FontWeight.w500 : FontWeight.bold,
                              ),
                            ),
                          ),
                          if (!leido)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: typeColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Mensaje
                      Text(
                        aviso['mensaje'] as String,
                        style: TextStyle(
                          color: ThemeConfig.gris,
                          fontSize: 14,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Fecha
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: ThemeConfig.gris.withValues(alpha: 0.7),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            aviso['fecha'] as String,
                            style: TextStyle(
                              color: ThemeConfig.gris.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
