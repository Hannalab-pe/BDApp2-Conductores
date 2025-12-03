import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/theme_config.dart';
import '../../../auth/domain/entities/user.dart';
import '../../data/models/despacho_model.dart';
import '../bloc/despacho_bloc.dart';
import '../bloc/despacho_event.dart';
import '../bloc/despacho_state.dart';

/// Sección de Despachos Asignados con datos reales de la API
class DespachosSection extends StatefulWidget {
  final User user;

  const DespachosSection({
    super.key,
    required this.user,
  });

  @override
  State<DespachosSection> createState() => _DespachosSectionState();
}

class _DespachosSectionState extends State<DespachosSection> {
  @override
  void initState() {
    super.initState();
    // Cargar despachos al inicializar
    context.read<DespachoBloc>().add(LoadDespachos(widget.user.id));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: BlocBuilder<DespachoBloc, DespachoState>(
              builder: (context, state) {
                if (state is DespachoLoading) {
                  return _buildLoading();
                } else if (state is DespachoLoaded) {
                  return _buildDespachosList(state.despachos);
                } else if (state is DespachoEmpty) {
                  return _buildEmpty();
                } else if (state is DespachoError) {
                  return _buildError(state.message);
                }
                return _buildLoading();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFFAFAFA),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¡Hola, ${widget.user.nombre.split(' ').first}!',
            style: TextStyle(
              color: ThemeConfig.negro,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tus despachos asignados',
            style: TextStyle(
              color: ThemeConfig.gris,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: ThemeConfig.rojo,
          ),
          const SizedBox(height: 16),
          Text(
            'Cargando despachos...',
            style: TextStyle(
              color: ThemeConfig.gris,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: ThemeConfig.gris.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No tienes despachos asignados',
            style: TextStyle(
              color: ThemeConfig.gris,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Los nuevos despachos aparecerán aquí',
            style: TextStyle(
              color: ThemeConfig.gris.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: ThemeConfig.rojo.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar despachos',
              style: TextStyle(
                color: ThemeConfig.negro,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeConfig.gris,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<DespachoBloc>().add(
                      RefreshDespachos(widget.user.id),
                    );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeConfig.rojo,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDespachosList(List<DespachoAsignadoModel> despachos) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DespachoBloc>().add(RefreshDespachos(widget.user.id));
        await Future.delayed(const Duration(seconds: 1));
      },
      color: ThemeConfig.rojo,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: despachos.length,
        itemBuilder: (context, index) {
          return _buildDespachoCard(despachos[index]);
        },
      ),
    );
  }

  Widget _buildDespachoCard(DespachoAsignadoModel despacho) {
    // Determinar color del estado
    Color estadoColor;
    IconData estadoIcon;

    switch (despacho.estadoEntrega.toUpperCase()) {
      case 'ASIGNADO':
        estadoColor = ThemeConfig.mostaza;
        estadoIcon = Icons.assignment_outlined;
        break;
      case 'EN_CAMINO':
        estadoColor = Colors.blue;
        estadoIcon = Icons.local_shipping_outlined;
        break;
      case 'ENTREGADO':
        estadoColor = Colors.green;
        estadoIcon = Icons.check_circle_outline;
        break;
      default:
        estadoColor = ThemeConfig.gris;
        estadoIcon = Icons.info_outline;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header del card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ID del despacho
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ThemeConfig.rojo.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: ThemeConfig.rojo.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    despacho.codigoDespacho,
                    style: TextStyle(
                      color: ThemeConfig.rojo,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Estado
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: estadoColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        estadoIcon,
                        color: estadoColor,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatEstado(despacho.estadoEntrega),
                        style: TextStyle(
                          color: estadoColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Cliente
            Row(
              children: [
                Icon(
                  Icons.business,
                  color: ThemeConfig.gris,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    despacho.cliente,
                    style: TextStyle(
                      color: ThemeConfig.negro,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Dirección
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: ThemeConfig.gris,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    despacho.direccion,
                    style: TextStyle(
                      color: ThemeConfig.gris,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Fecha y Hora
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: ThemeConfig.gris,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  _formatFecha(despacho.fecha),
                  style: TextStyle(
                    color: ThemeConfig.gris,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.access_time,
                  color: ThemeConfig.mostaza,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  _formatHora(despacho.hora),
                  style: TextStyle(
                    color: ThemeConfig.mostaza,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // Transportes
            if (despacho.transportes.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.local_shipping,
                    color: ThemeConfig.gris,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Placas: ${despacho.transportes.join(', ')}',
                      style: TextStyle(
                        color: ThemeConfig.gris,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 16),

            // Botones de acción
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Abrir mapa
                    },
                    icon: Icon(Icons.map, size: 18, color: ThemeConfig.rojo),
                    label: Text('Mapa', style: TextStyle(color: ThemeConfig.rojo)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: ThemeConfig.rojo,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Ver detalles / Iniciar entrega
                    },
                    icon: const Icon(Icons.info_outline, size: 18),
                    label: const Text('Detalles'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeConfig.rojo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatEstado(String estado) {
    switch (estado.toUpperCase()) {
      case 'ASIGNADO':
        return 'Asignado';
      case 'EN_CAMINO':
        return 'En Camino';
      case 'ENTREGADO':
        return 'Entregado';
      default:
        return estado;
    }
  }

  String _formatFecha(String fecha) {
    try {
      final date = DateTime.parse(fecha);
      final months = [
        'Ene',
        'Feb',
        'Mar',
        'Abr',
        'May',
        'Jun',
        'Jul',
        'Ago',
        'Sep',
        'Oct',
        'Nov',
        'Dic'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return fecha;
    }
  }

  String _formatHora(String hora) {
    try {
      // hora viene como "13:00:00"
      final parts = hora.split(':');
      if (parts.length >= 2) {
        return '${parts[0]}:${parts[1]}';
      }
      return hora;
    } catch (e) {
      return hora;
    }
  }
}
