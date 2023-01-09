import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:frusan_precios/src/providers/api_const_provider.dart';
import 'package:frusan_precios/src/models/nave_model.dart';
export 'package:frusan_precios/src/models/nave_model.dart';

class NaveProvider with ApiConstProvider {
  static final NaveProvider _provider = NaveProvider._internal();

  factory NaveProvider() {
    return _provider;
  }

  NaveProvider._internal();

  String _urlBase = 'productores.frusan.cl';

  Future<Naves> _procesarRespuesta(Uri url) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8
            .encode('${ApiConstProvider.userApi}:${ApiConstProvider.passApi}'));

    try {
      final response = await http
          .get(url, headers: {HttpHeaders.authorizationHeader: "$basicAuth"});

      final decodedData = json.decode(response.body);

      final recibidores = new Naves.fromJson(decodedData);

      return recibidores;
    } on SocketException catch (e) {
      return Future<Naves>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on Exception {
      return Future<Naves>.error(
          "Se produjo un error general al obtener las naves. Contactar a su administrador.");
    }
  }

  ///Mètodo que obtiene la informaciòn de los naves de la discrepancia precios
  Future<Naves> getDiscrepanciaPreciosNaves(int recibidor) async {
    var _recibidor = recibidor == null ? 0 : recibidor;

    try {
      final url = Uri.https(_urlBase,
          '/ApiPrecio/api/DiscrepanciaPrecio/Naves/recibidor/$_recibidor');

      return await _procesarRespuesta(url);
    } on SocketException catch (e) {
      return Future<Naves>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on PlatformException {
      return Future<Naves>.error(
          "Se produjo un error general al obtener los datos de las naves. Contactar a su administrador.");
    } on Exception {
      return Future<Naves>.error(
          "Se produjo un error general al obtener los datos de las naves. Contactar a su administrador.");
    } on NoSuchMethodError {
      return Future<Naves>.error(
          "Se produjo un error general al obtener los datos de las naves. Contactar a su administrador.");
    }
  }
}
