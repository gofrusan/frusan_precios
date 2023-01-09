class FormValueString {
  String _valor;

  String get valor => this._valor;

  set valor(String setValue) {
    this._valor = setValue;
  }
}

class FormValueInt {
  int _valorTemporada;
  int _valorProductor;

  int get valorTemporada => this._valorTemporada;

  set valorTemporada(int setValue) {
    this._valorTemporada = setValue;
  }

  int get valorProductor => this._valorProductor;

  set valorProductor(int setValue) {
    this._valorProductor = setValue;
  }
}

class DropDownValueInt {
  int valor;
  String texto;
  String nombreImagen;

  DropDownValueInt({valor, texto, nombreImagen}) {
    this.valor = valor;
    this.texto = texto;
    this.nombreImagen = nombreImagen;
  }
}

class DropDownValueDouble {
  double valor;
  String texto;
  String nombreImagen;

  DropDownValueDouble({valor, texto, nombreImagen}) {
    this.valor = valor;
    this.texto = texto;
    this.nombreImagen = nombreImagen;
  }
}

class DropDownValueString {
  String valor;
  String texto;

  DropDownValueString({valor, texto}){
    this.valor = valor;
    this.texto = texto;
  }

  DropDownValueString.fromValorTexto({valor, texto}) {
    this.valor = valor;
    this.texto = texto;
  }
}
