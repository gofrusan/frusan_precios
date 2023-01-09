import 'dart:io';
import 'package:flutter/services.dart';

import 'package:frusan_precios/src/models/columna_precio_model.dart';
import 'package:frusan_precios/src/providers/api_const_provider.dart';
export 'package:frusan_precios/src/models/columna_precio_model.dart';

class ColumnaPrecioProvider with ApiConstProvider {
  static final ColumnaPrecioProvider _provider =
      ColumnaPrecioProvider._internal();

  factory ColumnaPrecioProvider() {
    return _provider;
  }

  ColumnaPrecioProvider._internal();

  String _urlBase = 'productores.frusan.cl';

  Future<ColumnasPrecios> _procesarRespuestaPrecios(Uri url, bool precioEditable) async {
    try {
      return Future<ColumnasPrecios>.delayed(Duration(seconds: 1), () {
        ColumnasPrecios columnas = new ColumnasPrecios();

        columnas.data.add(ColumnaPrecio(
            key: "id", widthFactor: 0.0, title: "Id", editable: false, visible: false));
        columnas.data.add(ColumnaPrecio(
            key: "codigoNave", widthFactor: 0.20, title: "Nave", editable: false, visible: true));
        columnas.data.add(ColumnaPrecio(
            key: "descripcion",
            widthFactor: 0.55,
            title: "Descripción",
            editable: false, visible: true));
        columnas.data.add(ColumnaPrecio(
            key: "precio", widthFactor: 0.20, title: "Precio", editable: precioEditable, visible: true));

        return columnas;
      });
    } on SocketException catch (e) {
      return Future<ColumnasPrecios>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on Exception {
      return Future<ColumnasPrecios>.error(
          "Se produjo un error general al obtener las columnas de la discrepancia precios. Contactar a su administrador.");
    }
  }  

  ///Mètodo que obtiene la información de las especies
  Future<ColumnasPrecios> getColumnasDiscrepanciaPrecios({bool precioEditable}) async {
    try {
      final url =
          Uri.https(_urlBase, '/ApiProductor/api/Maestra/Especies/temp');

      return await _procesarRespuestaPrecios(url, precioEditable);
    } on SocketException catch (e) {
      return Future<ColumnasPrecios>.error(
          'Se produjo un error al tratar de conectarse a : ${e.address.address}.');
    } on PlatformException {
      return Future<ColumnasPrecios>.error(
          "Se produjo un error general al obtener las columnas precios. Contactar a su administrador.");
    } on Exception {
      return Future<ColumnasPrecios>.error(
          "Se produjo un error general al obtener las columnas precios.. Contactar a su administrador.");
    } on NoSuchMethodError {
      return Future<ColumnasPrecios>.error(
          "Se produjo un error general al obtener las columnas precios.. Contactar a su administrador.");
    }
  }  
}
