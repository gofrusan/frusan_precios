import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:frusan_precios/src/providers/api_const_provider.dart';
import 'package:frusan_precios/src/models/usuario_model.dart';
export 'package:frusan_precios/src/models/usuario_model.dart';

class UsuarioProvider with ApiConstProvider {
  static final UsuarioProvider _provider = UsuarioProvider._internal();

  factory UsuarioProvider() {
    return _provider;
  }

  UsuarioProvider._internal();

  String _urlBase = 'productores.frusan.cl';

  Future<Usuarios> _procesarRespuesta(Uri url) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8
            .encode('${ApiConstProvider.userApi}:${ApiConstProvider.passApi}'));

    try {
      final response = await http
          .get(url, headers: {HttpHeaders.authorizationHeader: "$basicAuth"});

      final decodedData = json.decode(response.body);

      final recibidores = new Usuarios.fromJson(decodedData);

      return recibidores;
    } on SocketException catch (e) {
      return Future<Usuarios>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on Exception {
      return Future<Usuarios>.error(
          "Se produjo un error general al obtener los datos del usuario. Contactar a su administrador.");
    }
  }

  ///Mètodo que obtiene la información del usuario logueado por uid
  Future<Usuarios> getInfoNombreUsuarioPorUid(String uid) async {
    var _uid = uid == null ? "" : uid;

    try {
      final url = Uri.https(
          _urlBase, '/ApiPrecio/api/DiscrepanciaPrecio/Usuario/uid/$_uid');

      return await _procesarRespuesta(url);
    } on SocketException catch (e) {
      return Future<Usuarios>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on PlatformException {
      return Future<Usuarios>.error(
          "Se produjo un error general al obtener los datos del usuario. Contactar a su administrador.");
    } on Exception {
      return Future<Usuarios>.error(
          "Se produjo un error general al obtener los datos del usuario. Contactar a su administrador.");
    } on NoSuchMethodError {
      return Future<Usuarios>.error(
          "Se produjo un error general al obtener los datos del usuario. Contactar a su administrador.");
    }
  }
}
