import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';
import 'core/config/theme_config.dart';
import 'core/network/dio_client.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar orientación de pantalla (solo vertical)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Configurar barra de estado para tema oscuro
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Iconos claros para fondo oscuro
      systemNavigationBarColor: Color(0xFF1A1A1A), // Negro
      systemNavigationBarIconBrightness: Brightness.light, // Iconos claros
    ),
  );

  // TODO: Inicializar dependencias (GetIt)
  // await initializeDependencies();

  // TODO: Inicializar Hive para almacenamiento local
  // await Hive.initFlutter();

  runApp(const BetondeckenApp());
}

/// Aplicación principal de Betondecken Conductores
class BetondeckenApp extends StatelessWidget {
  const BetondeckenApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configurar datasources según el entorno
    final dioClient = DioClient();
    final authRemoteDataSource = AuthRemoteDataSourceImpl(dioClient: dioClient);
    final authLocalDataSource = AuthLocalDataSourceImpl();

    return BlocProvider(
      create: (context) => AuthBloc(
        authLocalDataSource: authLocalDataSource,
        authRemoteDataSource: authRemoteDataSource,
        useRemoteApi: EnvConfig.useRemoteApi, // Cambiar en env_config.dart
      ),
      child: MaterialApp(
        title: AppConfig.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.lightTheme,
        darkTheme: ThemeConfig.darkTheme,
        themeMode: ThemeMode.dark, // Usar tema oscuro por defecto

        // Pantalla inicial - Splash
        home: const SplashPage(),

        // TODO: Configurar rutas con AppRouter para navegación completa
        // onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
