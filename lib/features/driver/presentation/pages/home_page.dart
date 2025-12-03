import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/theme_config.dart';
import '../../../../core/network/dio_client.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../data/datasources/despacho_remote_datasource.dart';
import '../bloc/despacho_bloc.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/despachos_section.dart';
import '../widgets/avisos_section.dart';

/// Pantalla principal del conductor (Home con Sidebar)
class HomePage extends StatefulWidget {
  final User user;
  final String token;

  const HomePage({
    super.key,
    required this.user,
    required this.token,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Secciones del home
  late final List<Widget> _sections;

  @override
  void initState() {
    super.initState();
    _sections = [
      DespachosSection(user: widget.user),
      AvisosSection(user: widget.user),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Crear instancia del DespachoBloc con DioClient y configurar el token
    final dioClient = DioClient();
    dioClient.updateAuthToken(widget.token); // Configurar el token JWT
    final despachoDataSource = DespachoRemoteDataSourceImpl(dioClient: dioClient);

    return BlocProvider(
      create: (context) => DespachoBloc(despachoRemoteDataSource: despachoDataSource),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black12,
        iconTheme: IconThemeData(color: ThemeConfig.negro),
        title: Text(
          _selectedIndex == 0 ? 'Despachos Asignados' : 'Avisos',
          style: TextStyle(
            color: ThemeConfig.negro,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Notificaciones
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications_outlined, color: ThemeConfig.negro),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: ThemeConfig.rojo,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notificaciones en desarrollo'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      drawer: CustomDrawer(user: widget.user),
      body: _sections[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          selectedItemColor: ThemeConfig.rojo,
          unselectedItemColor: ThemeConfig.gris,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping_outlined),
              activeIcon: Icon(Icons.local_shipping),
              label: 'Despachos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              activeIcon: Icon(Icons.notifications),
              label: 'Avisos',
            ),
          ],
        ),
      ),
      ),
    );
  }
}
