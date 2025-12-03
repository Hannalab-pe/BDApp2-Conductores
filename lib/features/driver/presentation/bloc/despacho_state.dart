import 'package:equatable/equatable.dart';
import '../../data/models/despacho_model.dart';

/// Estados del BLoC de Despachos
abstract class DespachoState extends Equatable {
  const DespachoState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class DespachoInitial extends DespachoState {
  const DespachoInitial();
}

/// Cargando despachos
class DespachoLoading extends DespachoState {
  const DespachoLoading();
}

/// Despachos cargados exitosamente
class DespachoLoaded extends DespachoState {
  final List<DespachoAsignadoModel> despachos;

  const DespachoLoaded(this.despachos);

  @override
  List<Object?> get props => [despachos];
}

/// Error al cargar despachos
class DespachoError extends DespachoState {
  final String message;

  const DespachoError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Despachos vacíos (sin asignaciones)
class DespachoEmpty extends DespachoState {
  const DespachoEmpty();
}
