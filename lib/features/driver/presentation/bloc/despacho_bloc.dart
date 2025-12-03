import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/despacho_remote_datasource.dart';
import '../../data/models/despacho_model.dart';
import 'despacho_event.dart';
import 'despacho_state.dart';

/// BLoC de Despachos
class DespachoBloc extends Bloc<DespachoEvent, DespachoState> {
  final DespachoRemoteDataSource despachoRemoteDataSource;

  DespachoBloc({required this.despachoRemoteDataSource})
      : super(const DespachoInitial()) {
    on<LoadDespachos>(_onLoadDespachos);
    on<RefreshDespachos>(_onRefreshDespachos);
  }

  /// Cargar despachos del conductor
  Future<void> _onLoadDespachos(
    LoadDespachos event,
    Emitter<DespachoState> emit,
  ) async {
    emit(const DespachoLoading());

    try {
      final despachosJson = await despachoRemoteDataSource.getDespachosByConductor(
        event.idConductor,
      );

      if (despachosJson.isEmpty) {
        emit(const DespachoEmpty());
        return;
      }

      // Convertir JSON a modelos
      final despachos = despachosJson
          .map((json) => DespachoAsignadoModel.fromJson(json))
          .toList();

      emit(DespachoLoaded(despachos));
    } catch (e) {
      emit(DespachoError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  /// Refrescar despachos
  Future<void> _onRefreshDespachos(
    RefreshDespachos event,
    Emitter<DespachoState> emit,
  ) async {
    // Mantener los datos actuales mientras se refresca
    if (state is DespachoLoaded) {
      // No emitir loading para no perder los datos en pantalla
    } else {
      emit(const DespachoLoading());
    }

    try {
      final despachosJson = await despachoRemoteDataSource.getDespachosByConductor(
        event.idConductor,
      );

      if (despachosJson.isEmpty) {
        emit(const DespachoEmpty());
        return;
      }

      final despachos = despachosJson
          .map((json) => DespachoAsignadoModel.fromJson(json))
          .toList();

      emit(DespachoLoaded(despachos));
    } catch (e) {
      emit(DespachoError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
