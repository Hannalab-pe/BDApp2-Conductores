# Arquitectura del Proyecto - Betondecken Conductores

## Visión General

Esta aplicación móvil para conductores de Betondecken está construida con **Flutter** siguiendo los principios de **Clean Architecture** y un enfoque **Feature-First** (módulos por funcionalidad).

## Principios Arquitectónicos

### 1. Clean Architecture
Separación clara en 3 capas por cada módulo:

- **Presentation Layer**: UI, páginas, widgets, BLoC
- **Domain Layer**: Entidades, casos de uso, interfaces de repositorios (lógica de negocio pura)
- **Data Layer**: Implementación de repositorios, modelos, data sources (local/remoto)

### 2. Feature-First Structure
Cada funcionalidad está completamente encapsulada en su propio módulo con todas sus capas.

### 3. Separation of Concerns
Cada capa tiene responsabilidades bien definidas y no conoce detalles de implementación de otras capas.

### 4. Dependency Rule
Las dependencias apuntan hacia adentro: Presentation → Domain ← Data

## Estructura de Carpetas

```
lib/
├── core/                          # Código compartido entre módulos
│   ├── config/                    # Configuraciones de la app
│   ├── constants/                 # Constantes globales
│   ├── errors/                    # Manejo de errores y excepciones
│   ├── network/                   # Cliente HTTP compartido
│   ├── utils/                     # Utilidades (validadores, formateadores)
│   └── widgets/                   # Widgets reutilizables
│
├── features/                      # Módulos por funcionalidad
│   ├── auth/                      # Autenticación y sesión
│   ├── driver/                    # Gestión de viajes y entregas
│   ├── tracking/                  # Rastreo GPS
│   └── settings/                  # Configuraciones del usuario
│
├── routes/                        # Sistema de navegación
├── di/                           # Inyección de dependencias
└── main.dart                     # Punto de entrada
```

## Módulos Principales

### 🔐 Auth (Autenticación)
**Responsabilidad**: Manejo de login, logout y sesión del usuario

**Capas**:
- **Presentation**: Login page, Splash page, Auth BLoC
- **Domain**: User entity, Login/Logout use cases
- **Data**: Auth API calls, token storage

### 🚚 Driver (Conductores)
**Responsabilidad**: Gestión de viajes, entregas y estado del conductor

**Capas**:
- **Presentation**: Home page, Trip details, Delivery confirmation, Driver BLoC
- **Domain**: Driver/Trip/Delivery entities, use cases para gestionar viajes
- **Data**: API de conductores, almacenamiento local de viajes

### 📍 Tracking (Rastreo GPS)
**Responsabilidad**: Seguimiento de ubicación en tiempo real

**Capas**:
- **Presentation**: Map page, Tracking BLoC
- **Domain**: Location entity, tracking use cases
- **Data**: GPS service, location API

### ⚙️ Settings (Configuraciones)
**Responsabilidad**: Preferencias del usuario

## Patrones y Tecnologías

### State Management
- **BLoC Pattern** (Business Logic Component)
- `flutter_bloc` para gestión de estados
- Estados inmutables con `equatable`

### Dependency Injection
- **GetIt** para service locator
- Configurado en `lib/di/injection_container.dart`

### Network
- **Dio** para HTTP requests
- Interceptors para autenticación
- Manejo de errores centralizado

### Local Storage
- **Hive** para datos estructurados
- **SharedPreferences** para preferencias simples

### Location
- **Geolocator** para GPS
- **Google Maps Flutter** para mapas

### Data Flow (Either Pattern)
- **Dartz** para manejo funcional de errores
- `Either<Failure, Success>` en repositorios

## Flujo de Datos

```
User Action
    ↓
[Presentation Layer - Widget]
    ↓
[BLoC - Event]
    ↓
[Use Case]
    ↓
[Repository Interface (Domain)]
    ↓
[Repository Implementation (Data)]
    ↓
[Data Source (Remote/Local)]
    ↓
[Response]
    ↓
[BLoC - State]
    ↓
[Widget Update]
```

## Manejo de Errores

### Failures (Domain)
Representan errores de negocio:
- `ServerFailure`: Errores del servidor
- `NetworkFailure`: Sin conexión
- `AuthFailure`: Errores de autenticación
- `CacheFailure`: Errores de almacenamiento local

### Exceptions (Data)
Excepciones técnicas lanzadas en la capa de datos y convertidas a Failures

## Configuración de Base de Datos

La aplicación se conectará a la base de datos existente de Betondecken mediante:

1. **API REST**: Endpoints configurados en `core/constants/api_constants.dart`
2. **Autenticación**: Token JWT para seguridad
3. **Sincronización**: Cache local con Hive para modo offline

### Endpoints Principales (Configurar según tu API)

```dart
// Auth
POST /api/auth/login
POST /api/auth/logout

// Drivers
GET /api/drivers/profile
GET /api/drivers/trips/active
POST /api/drivers/trips/start
POST /api/drivers/trips/complete

// Deliveries
GET /api/deliveries
POST /api/deliveries/complete

// Tracking
POST /api/tracking/location
```

## Próximos Pasos

1. **Instalar dependencias**: `flutter pub get`
2. **Configurar URLs de API** en `core/config/app_config.dart`
3. **Implementar pantalla de Login** en `features/auth/presentation/pages/`
4. **Crear modelos de datos** según tu base de datos
5. **Implementar repositorios** para conectar con tu API
6. **Configurar permisos** de ubicación en iOS/Android
7. **Agregar Google Maps API Key**

## Ventajas de esta Arquitectura

✅ **Escalable**: Fácil agregar nuevos módulos
✅ **Testeable**: Cada capa puede testearse independientemente
✅ **Mantenible**: Código organizado y predecible
✅ **Reutilizable**: Core compartido entre features
✅ **Offline-First**: Cache local con sincronización
✅ **Type-Safe**: Fuertemente tipado con Dart

## Convenciones de Código

- **Nombres de archivos**: snake_case (ej: `login_page.dart`)
- **Nombres de clases**: PascalCase (ej: `LoginPage`)
- **Nombres de variables**: camelCase (ej: `userName`)
- **Constantes**: lowerCamelCase con const (ej: `const errorMessage`)
- **Archivos por tipo**: Un widget/clase principal por archivo

## Referencias

- [Flutter Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Flutter Best Practices](https://flutter.dev/docs/development/ui/best-practices)
