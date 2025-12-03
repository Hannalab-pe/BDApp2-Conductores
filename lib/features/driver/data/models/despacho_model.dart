/// Modelo de Despacho Asignado desde la API
class DespachoAsignadoModel {
  final String id;
  final String codigoDespacho;
  final String fecha;
  final String hora;
  final String cliente;
  final String direccion;
  final String estadoEntrega;
  final bool verificado;
  final String? observaciones;
  final String? fechaSalida;
  final String? fechaEntrega;
  final int? cantidadGuias;
  final List<String> transportes;
  final DespachoInfoModel despachoInfo;

  DespachoAsignadoModel({
    required this.id,
    required this.codigoDespacho,
    required this.fecha,
    required this.hora,
    required this.cliente,
    required this.direccion,
    required this.estadoEntrega,
    required this.verificado,
    this.observaciones,
    this.fechaSalida,
    this.fechaEntrega,
    this.cantidadGuias,
    required this.transportes,
    required this.despachoInfo,
  });

  /// Crear desde JSON de la API
  factory DespachoAsignadoModel.fromJson(Map<String, dynamic> json) {
    final despacho = json['idDespacho'] as Map<String, dynamic>;
    final cliente = despacho['idCliente'] as Map<String, dynamic>;

    // Extraer placas de los transportes asignados
    final transportesData = json['asignacionTransportes'] as List<dynamic>? ?? [];
    final placas = transportesData
        .map((t) {
          final transporte = t['idTransporte'] as Map<String, dynamic>?;
          return transporte?['placa'] as String? ?? 'N/A';
        })
        .where((placa) => placa != 'N/A')
        .toList();

    // Construir dirección desde piso y nivel
    final piso = despacho['piso'] as String? ?? '';
    final nivel = despacho['nivel'] as String? ?? '';
    final direccion = '$piso - $nivel'.trim();

    return DespachoAsignadoModel(
      id: json['idAsignacionDespachoConductor'] as String,
      codigoDespacho: despacho['codigoDespacho'] as String,
      fecha: despacho['fecha'] as String,
      hora: despacho['hora'] as String,
      cliente: cliente['nombreComercial'] as String? ??
               cliente['razonSocial'] as String? ??
               'Cliente Desconocido',
      direccion: direccion.isNotEmpty ? direccion : 'Dirección no especificada',
      estadoEntrega: json['estadoEntrega'] as String? ?? 'ASIGNADO',
      verificado: json['verificado'] as bool? ?? false,
      observaciones: json['observaciones'] as String?,
      fechaSalida: json['fechaSalida'] as String?,
      fechaEntrega: json['fechaEntrega'] as String?,
      cantidadGuias: json['cantidadGuiasRemision'] as int?,
      transportes: placas,
      despachoInfo: DespachoInfoModel.fromJson(despacho),
    );
  }

  /// Convertir a Map para uso local
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigoDespacho': codigoDespacho,
      'fecha': fecha,
      'hora': hora,
      'cliente': cliente,
      'direccion': direccion,
      'estadoEntrega': estadoEntrega,
      'verificado': verificado,
      'observaciones': observaciones,
      'fechaSalida': fechaSalida,
      'fechaEntrega': fechaEntrega,
      'cantidadGuias': cantidadGuias,
      'transportes': transportes,
    };
  }
}

/// Información detallada del despacho
class DespachoInfoModel {
  final String idDespacho;
  final String codigoPlano;
  final String piso;
  final String nivel;
  final bool altaPrioridad;
  final bool estaCompletado;
  final bool estaEntregado;
  final String etapa;
  final String metrosCuadrados;
  final String metrosLineales;
  final String kilogramos;
  final int unidades;
  final String planta;
  final String rucCliente;

  DespachoInfoModel({
    required this.idDespacho,
    required this.codigoPlano,
    required this.piso,
    required this.nivel,
    required this.altaPrioridad,
    required this.estaCompletado,
    required this.estaEntregado,
    required this.etapa,
    required this.metrosCuadrados,
    required this.metrosLineales,
    required this.kilogramos,
    required this.unidades,
    required this.planta,
    required this.rucCliente,
  });

  factory DespachoInfoModel.fromJson(Map<String, dynamic> json) {
    final cliente = json['idCliente'] as Map<String, dynamic>? ?? {};
    final planta = json['idPlanta'] as Map<String, dynamic>? ?? {};

    return DespachoInfoModel(
      idDespacho: json['idDespacho'] as String,
      codigoPlano: json['codigoPlano'] as String? ?? '-',
      piso: json['piso'] as String? ?? '',
      nivel: json['nivel'] as String? ?? '',
      altaPrioridad: json['altaPrioridad'] as bool? ?? false,
      estaCompletado: json['estaCompletado'] as bool? ?? false,
      estaEntregado: json['estaEntregado'] as bool? ?? false,
      etapa: json['etapa'] as String? ?? 'PENDIENTE',
      metrosCuadrados: json['metrosCuadrados'] as String? ?? '0.00',
      metrosLineales: json['metrosLineales'] as String? ?? '0.00',
      kilogramos: json['kilogramos'] as String? ?? '0.00',
      unidades: json['unidades'] as int? ?? 0,
      planta: planta['nombre'] as String? ?? 'N/A',
      rucCliente: cliente['ruc'] as String? ?? '',
    );
  }
}
