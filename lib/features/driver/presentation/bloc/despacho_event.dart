import 'package:equatable/equatable.dart';

/// Eventos del BLoC de Despachos
abstract class DespachoEvent extends Equatable {
  const DespachoEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para cargar despachos del conductor
class LoadDespachos extends DespachoEvent {
  final String idConductor;

  const LoadDespachos(this.idConductor);

  @override
  List<Object?> get props => [idConductor];
}

/// Evento para refrescar despachos
class RefreshDespachos extends DespachoEvent {
  final String idConductor;

  const RefreshDespachos(this.idConductor);

  @override
  List<Object?> get props => [idConductor];
}
