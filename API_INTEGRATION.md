# 🔌 Integración con API - Betondecken Conductores

## ✅ Cambios Implementados

### 1. **Tipografía Moderna**
- ✅ Fuente **Inter** de Google Fonts
- ✅ Más legible y profesional
- ✅ Aplicada a toda la app (login y home)

### 2. **Estructura de Servicios API**
Se creó una arquitectura completa y organizada para conectar con la API de Betondecken:

```
lib/
├── core/
│   ├── config/
│   │   ├── env_config.dart          # ⚙️ Configuración de entorno
│   │   └── api_config.dart          # 🔗 URLs y endpoints
│   └── network/
│       └── dio_client.dart          # 📡 Cliente HTTP con Dio
└── features/
    └── auth/
        └── data/
            └── datasources/
                ├── auth_local_datasource.dart   # 💾 Login local (desarrollo)
                └── auth_remote_datasource.dart  # 🌐 Login con API real
```

---

## 🚀 Cómo Usar la API Real

### Paso 1: Configurar la URL de tu API

Edita el archivo [lib/core/config/env_config.dart](lib/core/config/env_config.dart):

```dart
class EnvConfig {
  // 👉 Cambiar a true para usar la API real
  static const bool useRemoteApi = true;

  // 👉 Reemplazar con la URL de tu servidor
  static const String apiBaseUrl = 'https://api.tuservidor.com';
}
```

### Paso 2: Verificar el Endpoint de Login

El endpoint configurado es:
```
POST /api/v1/auth/login
```

Formato esperado del request:
```json
{
  "correo": "conductor123@betondecken.com",
  "contrasena": "conductor123"
}
```

Formato esperado de la respuesta (Status 200/201):
```json
{
  "user": {
    "id": "COND-001",
    "nombre": "Juan Pérez",
    "email": "conductor123@betondecken.com",
    "telefono": "+52 123 456 7890",
    "rol": "conductor",
    "activo": true,
    "foto": "https://..."
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

---

## 🔄 Modo Desarrollo vs Producción

### Modo Desarrollo (Local)
```dart
// En env_config.dart
static const bool useRemoteApi = false;
```

✅ Usa credenciales hardcodeadas
✅ No requiere conexión a internet
✅ Perfecto para diseño y pruebas de UI

**Credenciales de desarrollo:**
- Email: `conductor123@betondecken.com`
- Password: `conductor123`

### Modo Producción (API Real)
```dart
// En env_config.dart
static const bool useRemoteApi = true;
static const String apiBaseUrl = 'https://tu-api-real.com';
```

✅ Conecta con tu API real
✅ Autentica usuarios reales
✅ Maneja tokens JWT
✅ Gestión de errores completa

---

## 📡 Manejo de Errores

El `AuthRemoteDataSource` maneja automáticamente los siguientes errores:

| Código | Error | Mensaje al Usuario |
|--------|-------|-------------------|
| 400 | Bad Request | "Credenciales inválidas" |
| 401 | Unauthorized | "Email o contraseña incorrectos" |
| 403 | Forbidden | "Usuario inactivo o cuenta bloqueada" |
| 404 | Not Found | "Usuario no encontrado" |
| 500 | Server Error | "Error interno del servidor" |
| Timeout | Connection Timeout | "Tiempo de espera agotado" |
| Network | Connection Error | "No se pudo conectar al servidor" |

---

## 🔐 Flujo de Autenticación

1. Usuario ingresa email y contraseña
2. App envía POST a `/api/v1/auth/login`
3. API valida credenciales
4. API responde con `user` y `token`
5. App guarda el token
6. Token se incluye en headers de futuras peticiones:
   ```
   Authorization: Bearer {token}
   ```

---

## 📝 Logs y Debugging

El `DioClient` incluye logging automático de todas las peticiones:

```dart
// En la consola verás:
REQUEST[POST] => PATH: /api/v1/auth/login
Headers: {Content-Type: application/json, ...}
Body: {correo: conductor@..., contrasena: ***}

RESPONSE[200] => PATH: /api/v1/auth/login
Data: {user: {...}, token: ...}
```

---

## 🛠️ Próximos Pasos

### Para conectar con tu API real:

1. **Obtén la URL base de tu API** (ej: `https://api.betondecken.com`)

2. **Actualiza `env_config.dart`**:
   ```dart
   static const bool useRemoteApi = true;
   static const String apiBaseUrl = 'https://tu-url-real.com';
   ```

3. **Verifica que tu API responda con el formato correcto**:
   - Campo `user` con objeto completo
   - Campo `token` con JWT string

4. **Prueba el login** con credenciales reales

5. **Revisa los logs** en la consola para debuggear

---

## 🎯 Endpoints Adicionales Disponibles

Ya está configurado para agregar más endpoints fácilmente:

```dart
// En api_config.dart
static const String driverDespachosEndpoint = '/conductores/despachos';
static const String driverAvisosEndpoint = '/conductores/avisos';
```

Para usarlos, solo necesitas crear los datasources correspondientes siguiendo el mismo patrón de `auth_remote_datasource.dart`.

---

## ✨ Características Implementadas

✅ Cliente HTTP con Dio configurado
✅ Interceptores para logging
✅ Manejo automático de tokens JWT
✅ Gestión completa de errores
✅ Modo desarrollo y producción
✅ Timeouts configurables
✅ Headers personalizados
✅ Serialización JSON automática

---

## 📞 ¿Necesitas Ayuda?

Si tienes dudas sobre cómo configurar la API:

1. Verifica la URL base de tu servidor
2. Confirma que el endpoint es `/api/v1/auth/login`
3. Revisa el formato de respuesta de tu API
4. Chequea los logs en la consola
5. Asegúrate que el servidor esté corriendo

**¡Tu app está lista para conectarse con la API real de Betondecken!** 🚀
