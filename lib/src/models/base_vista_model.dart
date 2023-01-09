import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

abstract class BaseVistaEntidad<T> {
  List<Exception> _errores;
  String _codigo;
  String _mensaje;

  BaseVistaEntidad() {
    this._errores = [];
    this._codigo = '';
    this._mensaje = '';
  }

  bool get exitoso => this._errores.length == 0;
  String get getCodigo => this._codigo;
  String get getMensaje => this._mensaje;

  List<Exception> get getErrores => this._errores;

  set setErrores(valor) {

    if (valor is FirebaseAuthException) {
      this._codigo = valor.code;
      this._mensaje = valor.message;
    }

    if (valor is PlatformException) {
      this._codigo = valor.code;
      this._mensaje = valor.message;
    }

    this._errores.add(valor);
  }
}
