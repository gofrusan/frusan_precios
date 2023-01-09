import 'package:rxdart/rxdart.dart';

import 'package:frusan_precios/src/providers/fila_precio_provider.dart';
import 'package:frusan_precios/src/providers/columna_precio_provider.dart';
import 'package:frusan_precios/src/models/vista_precio.dart';
import 'package:frusan_precios/src/models/form_precio_view.dart';
export 'package:frusan_precios/src/models/vista_precio.dart';
export 'package:frusan_precios/src/models/form_precio_view.dart';

class VistaPrecioService {
  final _vistaPrecioController = new BehaviorSubject<VistaPrecio>();

  Stream<VistaPrecio> get vistaPrecioStream => _vistaPrecioController.stream;

  final _columnaProvider = new ColumnaPrecioProvider();
  final _filaProvider = new FilaPrecioProvider();

  ///Método que obtiene lista de precios con opcion
  Future<VistaPrecio> obtenerListaVistaPrecios(FormPrecioView view) async {
    VistaPrecio response = new VistaPrecio();

    try {
      final columnaResponse = await _columnaProvider
          .getColumnasDiscrepanciaPrecios(precioEditable: true);
      final columnaPropuestoResponse = await _columnaProvider
          .getColumnasDiscrepanciaPrecios(precioEditable: false);
      //final filaResponse = await _filaProvider.getListaDiscrepanciaPrecios(view.valorRecibidor, view.valorNave);
      final filaResponse = await _filaProvider
          .getListaDiscrepanciaPreciosWithNave(view.valorRecibidor);

      final filaPropuestoResponse = await _filaProvider
          .getListaDiscrepanciaPreciosPropuestosWithNave(view.valorRecibidor);

      response.valorColumnas = columnaResponse;
      response.valorFilas = filaResponse;
      response.valorColumnasPropuestas = columnaPropuestoResponse;
      response.valorFilasPropuestas = filaPropuestoResponse;

      if (view.valorPrecio != null) {
        response.valorFilas.data.forEach((element) {
          //element.status = view.valorPrecio.toString();
          element.precio = view.valorPrecio;
        });

        view.valorPrecio = null;
      }
      _vistaPrecioController.sink.add(response);
    } catch (e) {
      _vistaPrecioController.sink.addError(e);
      //return Future<Variedades>.error(e);
    }

    return response;
  }

  ///Método que obtiene lista de precios propuestos con opcion
  Future<VistaPrecio> obtenerListaVistaPreciosPropuestos(
      FormPrecioView view) async {
    VistaPrecio response = new VistaPrecio();

    try {
      final columnaResponse = await _columnaProvider
          .getColumnasDiscrepanciaPrecios(precioEditable: true);
      final columnaPropuestoResponse = await _columnaProvider
          .getColumnasDiscrepanciaPrecios(precioEditable: false);
      //final filaResponse = await _filaProvider.getListaDiscrepanciaPrecios(view.valorRecibidor, view.valorNave);

      final filaPropuestoResponse = await _filaProvider
          .getListaDiscrepanciaPreciosPropuestosWithNave(view.valorRecibidor);

      response.valorColumnas = columnaResponse;
      response.valorFilas = filaPropuestoResponse;
      response.valorColumnasPropuestas = columnaPropuestoResponse;
      response.valorFilasPropuestas = filaPropuestoResponse;

      if (view.valorPrecio != null) {
        response.valorFilas.data.forEach((element) {
          //element.status = view.valorPrecio.toString();
          element.precio = view.valorPrecio;
        });

        view.valorPrecio = null;
      }
      _vistaPrecioController.sink.add(response);
    } catch (e) {
      _vistaPrecioController.sink.addError(e);
      //return Future<Variedades>.error(e);
    }

    return response;
  }

  ///Método que envia los datos de la lista de discrepancia precios
  Future<VistaPrecio> setearListaVistaPrecios(List<dynamic> lista) async {
    VistaPrecio response = new VistaPrecio();

    try {
      final filaResponse =
          await _filaProvider.setListaDiscrepanciaPrecios(lista);
      response.valorFilas = filaResponse;
    } catch (e) {
      return Future<VistaPrecio>.error(e);
    }

    return response;
  }

  dispose() {
    _vistaPrecioController?.close();
  }
}
