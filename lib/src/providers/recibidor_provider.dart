import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:frusan_precios/src/providers/api_const_provider.dart';
import 'package:frusan_precios/src/models/recibidor_model.dart';
export 'package:frusan_precios/src/models/recibidor_model.dart';

class RecibidorProvider with ApiConstProvider {
  static final RecibidorProvider _provider = RecibidorProvider._internal();

  factory RecibidorProvider() {
    return _provider;
  }

  RecibidorProvider._internal();

  String _urlBase = 'productores.frusan.cl';

  Future<Recibidores> _procesarRespuesta(Uri url) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8
            .encode('${ApiConstProvider.userApi}:${ApiConstProvider.passApi}'));

    try {
      final response = await http
          .get(url, headers: {HttpHeaders.authorizationHeader: "$basicAuth"});

      final decodedData = json.decode(response.body);

      final recibidores = new Recibidores.fromJson(decodedData);

      return recibidores;
    } on SocketException catch (e) {
      return Future<Recibidores>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on Exception {
      return Future<Recibidores>.error(
          "Se produjo un error general al obtener los recibidores. Contactar a su administrador.");
    }
  }

  ///Mètodo que obtiene la informaciòn de los recibidores de la discrepancia precios
  Future<Recibidores> getDiscrepanciaPreciosRecibidores(String usuario) async {
    try {
      final url = Uri.https(_urlBase,
          '/ApiPrecio/api/DiscrepanciaPrecio/Recibidores/usuario/$usuario');

      return await _procesarRespuesta(url);
    } on SocketException catch (e) {
      return Future<Recibidores>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on PlatformException {
      return Future<Recibidores>.error(
          "Se produjo un error general al obtener los datos de los recibidores. Contactar a su administrador.");
    } on Exception {
      return Future<Recibidores>.error(
          "Se produjo un error general al obtener los datos de los recibidores. Contactar a su administrador.");
    } on NoSuchMethodError {
      return Future<Recibidores>.error(
          "Se produjo un error general al obtener los datos de los recibidores. Contactar a su administrador.");
    }
  }
}
