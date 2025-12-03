import 'package:equatable/equatable.dart';

/// Entidad de Usuario - Representa un conductor de Betondecken
class User extends Equatable {
  final String id;
  final String nombre;
  final String email;
  final String? telefono;
  final String rol; // 'conductor'
  final bool activo;
  final String? foto;

  const User({
    required this.id,
    required this.nombre,
    required this.email,
    this.telefono,
    required this.rol,
    this.activo = true,
    this.foto,
  });

  @override
  List<Object?> get props => [id, nombre, email, telefono, rol, activo, foto];

  @override
  String toString() {
    return 'User(id: $id, nombre: $nombre, email: $email, rol: $rol)';
  }
}
