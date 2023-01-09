
import 'package:frusan_precios/src/models/columna_precio_model.dart';
import 'package:frusan_precios/src/models/fila_precio_model.dart';

class VistaPrecio {
  ColumnasPrecios _valorColumnas;
  ColumnasPrecios _valorColumnasPropuestas;
  FilasPrecios _valorFilas;  
  FilasPrecios _valorFilasPropuestas;

  VistaPrecio() {
    this._valorColumnas = new ColumnasPrecios();
    this._valorFilas = new FilasPrecios();
    this._valorFilasPropuestas = new FilasPrecios();
  }

  ColumnasPrecios get valorColumnas => this._valorColumnas;

  set valorColumnas(ColumnasPrecios valor) {
    this._valorColumnas = valor;
  }

  ColumnasPrecios get valorColumnasPropuestas => this._valorColumnasPropuestas;

  set valorColumnasPropuestas(ColumnasPrecios valor) {
    this._valorColumnasPropuestas = valor;
  }

  FilasPrecios get valorFilas => this._valorFilas;

  set valorFilas(FilasPrecios valor) {
    this._valorFilas = valor;
  }

  FilasPrecios get valorFilasPropuestas => this._valorFilasPropuestas;

  set valorFilasPropuestas(FilasPrecios valor) {
    this._valorFilasPropuestas = valor;
  }
}
