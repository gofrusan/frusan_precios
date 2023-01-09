
class FormPrecioView {
  int _valorRecibidor;
  String _valorNave;
  double _valorPrecio;
  List<dynamic> _jsonColumnasPropuestas;
  List<dynamic> _jsonFilasPropuestas;

  int get valorRecibidor => this._valorRecibidor;

  set valorRecibidor(int setValue) {
    this._valorRecibidor = setValue;
  }

  String get valorNave => this._valorNave;

  set valorNave(String setValue) {
    this._valorNave = setValue;
  }

  double get valorPrecio => this._valorPrecio;

  set valorPrecio(double setValue) {
    this._valorPrecio = setValue;
  }  

  List<dynamic> get jsonColumnasPropuestas => this._jsonColumnasPropuestas;

  set jsonColumnasPropuestas(List<dynamic> valor) {
    this._jsonColumnasPropuestas = valor;
  }

  List<dynamic> get jsonFilasPropuestas => this._jsonFilasPropuestas;

  set jsonFilasPropuestas(List<dynamic> valor) {
    this._jsonFilasPropuestas = valor;
  }
}
