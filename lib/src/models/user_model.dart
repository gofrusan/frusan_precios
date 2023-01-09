import 'package:frusan_precios/src/models/base_vista_model.dart';

class UserInside extends BaseVistaEntidad<UserInside> {
  UserInside({this.uid});
  final String uid;

  String _segUsrId;

  String get segUsrId => this._segUsrId;

  set segUsrId(String setValue) {
    this._segUsrId = setValue;
  }
  /*@override
  set setErrores(valor) {
    super.errores.add(valor);
  } */
}
