import 'package:rxdart/rxdart.dart';

import 'package:frusan_precios/src/providers/nave_provider.dart';
export 'package:frusan_precios/src/providers/nave_provider.dart';

class NaveService {
  final _naveController = new BehaviorSubject<Naves>();

  Stream<Naves> get naveStream => _naveController.stream;

  final _naveProvider = new NaveProvider();

  ///Método que obtiene la lista de naves empty
  Future<Naves> obtenerListaDiscrepanciaPrecioNavesEmpty() async {
    Naves response;

    try {
      response = await Future.sync(() => Naves());
      _naveController.sink.add(response);
    } catch (e) {
      _naveController.sink.addError(e);
    }

    return response;
  }

  ///Método que obtiene la lista de naves por recibidor,
  Future<Naves> obtenerListaDiscrepanciaPrecioNaves(int recibidor) async {
    Naves response;

    try {
      response = await _naveProvider.getDiscrepanciaPreciosNaves(recibidor);
      _naveController.sink.add(response);
    } catch (e) {
      _naveController.sink.addError(e);
      //return Future<Especies>.error(e);
    }

    return response;
  }

  dispose() {
    _naveController?.close();
  }
}