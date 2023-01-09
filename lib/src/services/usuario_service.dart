import 'package:frusan_precios/src/providers/usuario_provider.dart';
export 'package:frusan_precios/src/providers/usuario_provider.dart';

class UsuarioService {
  final _usuarioProvider = new UsuarioProvider();

  ///Método que obtiene la informacion del usuario nombre por uid
  Future<Usuarios> obtenerInfoUsuarioNombrePorUId(String uid) async {
    Usuarios response;

    try {
      response = await _usuarioProvider.getInfoNombreUsuarioPorUid(uid);
    } catch (e) {
      return Future<Usuarios>.error(e);
    }

    return response;
  }
}