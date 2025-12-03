# Betondecken Conductores App

Aplicación móvil para conductores de Betondecken construida con Flutter para iOS y Android.

## Características

- 🔐 Autenticación segura con JWT
- 🚚 Gestión de viajes y entregas
- 📍 Rastreo GPS en tiempo real
- 📱 Compatible con iOS y Android
- 🔄 Sincronización con base de datos existente
- 💾 Modo offline con cache local

## Arquitectura

Este proyecto sigue **Clean Architecture** con estructura **Feature-First**.

Ver [ARCHITECTURE.md](ARCHITECTURE.md) para documentación completa de la arquitectura.

### Estructura del Proyecto

```
lib/
├── core/          # Código compartido
├── features/      # Módulos por funcionalidad
│   ├── auth/      # Autenticación
│   ├── driver/    # Conductores
│   ├── tracking/  # GPS
│   └── settings/  # Configuraciones
├── routes/        # Navegación
├── di/           # Inyección de dependencias
└── main.dart     # Punto de entrada
```

## Tecnologías Principales

- **Flutter SDK**: 3.9.2
- **State Management**: BLoC Pattern
- **Network**: Dio
- **Local Storage**: Hive + SharedPreferences
- **Maps**: Google Maps Flutter
- **Location**: Geolocator
- **DI**: GetIt

## Instalación

### Prerrequisitos

- Flutter SDK 3.9.2 o superior
- Dart 3.x
- Android Studio / Xcode
- Google Maps API Key (para mapas)

### Pasos

1. **Clonar el repositorio** (o ya estás en él)

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar la API**

   Edita `lib/core/config/app_config.dart`:
   ```dart
   static const String baseUrl = 'https://tu-api.betondecken.com';
   ```

4. **Configurar Google Maps API Key**

   **Android**: `android/app/src/main/AndroidManifest.xml`
   ```xml
   <meta-data
       android:name="com.google.android.geo.API_KEY"
       android:value="TU_API_KEY"/>
   ```

   **iOS**: `ios/Runner/AppDelegate.swift`
   ```swift
   GMSServices.provideAPIKey("TU_API_KEY")
   ```

5. **Ejecutar la aplicación**
   ```bash
   # Android
   flutter run

   # iOS
   flutter run -d ios
   ```

## Configuración de Permisos

### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Se necesita tu ubicación para rastrear entregas</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>Se necesita tu ubicación para rastrear entregas en segundo plano</string>
```

## Desarrollo

### Comandos Útiles

```bash
# Instalar dependencias
flutter pub get

# Limpiar proyecto
flutter clean

# Generar código (JSON serialization, Hive)
flutter pub run build_runner build --delete-conflicting-outputs

# Ejecutar tests
flutter test

# Analizar código
flutter analyze

# Build para producción
flutter build apk --release
flutter build ios --release
```

### Crear un Nuevo Módulo

1. Crear estructura en `lib/features/nombre_modulo/`:
   ```
   nombre_modulo/
   ├── data/
   │   ├── datasources/
   │   ├── models/
   │   └── repositories/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/
   │   └── usecases/
   └── presentation/
       ├── bloc/
       ├── pages/
       └── widgets/
   ```

2. Seguir el patrón de módulos existentes

## Integración con Base de Datos

La app se conecta a la base de datos existente de Betondecken mediante API REST.

### Endpoints Esperados

Ver `lib/core/constants/api_constants.dart` para la lista completa de endpoints.

Debes implementar en tu backend:
- `/api/auth/login` - Autenticación
- `/api/drivers/trips/active` - Viajes activos
- `/api/deliveries` - Entregas
- `/api/tracking/location` - Actualización de ubicación

## Estado del Proyecto

### ✅ Completado
- Estructura de carpetas modular
- Configuración de dependencias
- Configuración de tema oscuro corporativo
- Constantes y configuraciones base
- Sistema de manejo de errores
- Validadores de formularios
- **Splash Screen con animaciones**
- **Login con diseño oscuro moderno**
  - Fondo de concreto con overlay
  - Logo corporativo Betondecken
  - Inputs transparentes con glassmorphism
  - Validaciones en tiempo real
  - BLoC pattern implementado

### 🚧 Por Implementar

- [ ] Integración con API de Betondecken
- [ ] Persistencia de sesión (Hive)
- [ ] Pantalla Home del conductor
- [ ] Módulo de conductores completo
- [ ] Sistema de rastreo GPS
- [ ] Sincronización offline
- [ ] Notificaciones push
- [ ] Tests unitarios y de integración

## Contribuir

1. Crear una rama para tu feature: `git checkout -b feature/nombre`
2. Commit de cambios: `git commit -m 'Agregar feature'`
3. Push a la rama: `git push origin feature/nombre`
4. Crear Pull Request

## Convenciones de Código

- Usar BLoC para state management
- Seguir Clean Architecture
- Nombres de archivos en snake_case
- Clases en PascalCase
- Comentar código complejo
- Escribir tests para lógica de negocio

## Licencia

Proyecto privado de Betondecken

## Soporte

Para preguntas o problemas, contactar al equipo de desarrollo de Betondecken.

---

**Versión**: 1.0.0
**Flutter**: 3.9.2
**Última actualización**: 2025-12-01
