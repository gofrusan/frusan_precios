import 'package:frusan_precios/src/providers/recibidor_provider.dart';
export 'package:frusan_precios/src/providers/recibidor_provider.dart';

class RecibidorService {
  final _recibidorProvider = new RecibidorProvider();

  ///Método que obtiene la de recibidores por discrepancia
  Future<Recibidores> obtenerListaDiscrepanciaPrecioRecibidores(String uid) async {
    Recibidores response;

    try {
      response = await _recibidorProvider.getDiscrepanciaPreciosRecibidores(uid);
    } catch (e) {
      return Future<Recibidores>.error(e);
    }

    return response;
  }
}