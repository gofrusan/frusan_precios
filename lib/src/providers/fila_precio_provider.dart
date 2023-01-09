import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:frusan_precios/src/providers/api_const_provider.dart';

import 'package:frusan_precios/src/models/fila_precio_model.dart';
export 'package:frusan_precios/src/models/fila_precio_model.dart';

class FilaPrecioProvider with ApiConstProvider {
  static final FilaPrecioProvider _provider = FilaPrecioProvider._internal();

  factory FilaPrecioProvider() {
    return _provider;
  }

  FilaPrecioProvider._internal();

  String _urlBase = 'productores.frusan.cl';

  Future<FilasPrecios> _procesarRespuesta(Uri url) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8
            .encode('${ApiConstProvider.userApi}:${ApiConstProvider.passApi}'));

    try {
      final response = await http
          .get(url, headers: {HttpHeaders.authorizationHeader: "$basicAuth"});

      final decodedData = json.decode(response.body);

      final filasPrecios = new FilasPrecios.fromJson(decodedData);

      return filasPrecios;
    } on SocketException catch (e) {
      return Future<FilasPrecios>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on Exception {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    }
  }

  //Método que realiza un post con los datos de los precios
  Future<FilasPrecios> _procesarRespuestaPost(
      Uri url, List<dynamic> precios) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8
            .encode('${ApiConstProvider.userApi}:${ApiConstProvider.passApi}'));

    try {
      //encode Map to JSON
      final body = json.encode(precios);

      final response = await http.post(url,
          headers: {
            //"Content-Type": "application/json",
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "$basicAuth"
          },
          body: body);

      //final response = await http.get(url, headers: {HttpHeaders.authorizationHeader: "$basicAuth"});

      final decodedData = json.decode(response.body);

      final filasPrecios = new FilasPrecios.fromJson(decodedData);

      return filasPrecios;
    } on SocketException catch (e) {
      return Future<FilasPrecios>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on Exception {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al enviar los datos de los precios la discrepancia de precios. Contactar a su administrador.");
    }
  }

  ///Método que obtiene la lista de la discrepancia de precios por productor y nave
  Future<FilasPrecios> getListaDiscrepanciaPrecios(
      int recibidor, String nave) async {
    int _recibidor = recibidor == null ? 0 : recibidor;
    String _nave = nave == null ? "" : nave;

    try {
      final url = Uri.https(_urlBase,
          'ApiPrecio/api/DiscrepanciaPrecio/Precios/recibidor/$_recibidor/nave/$_nave');

      return await _procesarRespuesta(url);
    } on SocketException catch (e) {
      return Future<FilasPrecios>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on PlatformException {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    } on Exception {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    } on NoSuchMethodError {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    }
  }

  ///Método que obtiene la lista de la discrepancia de precios por productor
  Future<FilasPrecios> getListaDiscrepanciaPreciosWithNave(
      int recibidor) async {
    int _recibidor = recibidor == null ? 0 : recibidor;

    try {
      final url = Uri.https(_urlBase,
          'ApiPrecio/api/DiscrepanciaPrecio/Precios/recibidor/$_recibidor');

      return await _procesarRespuesta(url);
    } on SocketException catch (e) {
      return Future<FilasPrecios>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on PlatformException {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    } on Exception {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    } on NoSuchMethodError {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    }
  }

  ///Método que obtiene la lista de la discrepancia de precios por productor
  Future<FilasPrecios> getListaDiscrepanciaPreciosPropuestosWithNave(
      int recibidor) async {
    int _recibidor = recibidor == null ? 0 : recibidor;

    try {
      final url = Uri.https(_urlBase,
          'ApiPrecio/api/DiscrepanciaPrecio/PreciosPropuestos/recibidor/$_recibidor');

      return await _procesarRespuesta(url);
    } on SocketException catch (e) {
      return Future<FilasPrecios>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on PlatformException {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    } on Exception {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    } on NoSuchMethodError {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    }
  }

  ///Método que setea los datos de los precios
  Future<FilasPrecios> setListaDiscrepanciaPrecios(
      List<dynamic> precios) async {
    List<dynamic> _precios = precios == null ? new Map() : precios;

    try {
      final url =
          Uri.https(_urlBase, 'ApiPrecio/api/DiscrepanciaPrecio/Precios');

      return await _procesarRespuestaPost(url, _precios);
    } on SocketException catch (e) {
      return Future<FilasPrecios>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on PlatformException {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    } on Exception {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    } on NoSuchMethodError {
      return Future<FilasPrecios>.error(
          "Se produjo un error general al obtener la discrepancia de precios. Contactar a su administrador.");
    }
  }
}
