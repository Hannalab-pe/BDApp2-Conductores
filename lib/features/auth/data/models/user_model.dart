import '../../domain/entities/user.dart';

/// Modelo de Usuario con serialización JSON
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.nombre,
    required super.email,
    super.telefono,
    required super.rol,
    super.activo,
    super.foto,
  });

  /// Crear desde JSON de la API
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      email: json['email'] as String,
      telefono: json['telefono'] as String?,
      rol: json['rol'] as String,
      activo: json['estaActivo'] as bool? ?? true, // API usa 'estaActivo'
      foto: json['foto'] as String?,
    );
  }

  /// Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'telefono': telefono,
      'rol': rol,
      'estaActivo': activo, // API usa 'estaActivo'
      'foto': foto,
    };
  }

  /// Crear desde entidad
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      nombre: user.nombre,
      email: user.email,
      telefono: user.telefono,
      rol: user.rol,
      activo: user.activo,
      foto: user.foto,
    );
  }

  /// Convertir a entidad
  User toEntity() {
    return User(
      id: id,
      nombre: nombre,
      email: email,
      telefono: telefono,
      rol: rol,
      activo: activo,
      foto: foto,
    );
  }
}
