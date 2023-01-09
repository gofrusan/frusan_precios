import 'dart:convert';

Nave naveFromJson(String str) => Nave.fromJson(json.decode(str));

String naveToJson(Nave data) => json.encode(data.toJson());

class Naves {
  List<Nave> data = [];
  String error;
  dynamic code;

  Naves();

  Naves.fromParameters({
    this.data,
    this.error,
    this.code,
  });

  factory Naves.fromJson(Map<String, dynamic> json) => Naves.fromParameters(
        data: json["Data"] == null
            ? []
            : List<Nave>.from(json["Data"].map((x) => Nave.fromJson(x))),
        error: json["Error"],
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Error": error,
        "Code": code,
      };
}

class Nave {
  Nave({
    this.codigo,
    this.nombre,
  });

  String codigo;
  String nombre;

  factory Nave.fromJson(Map<String, dynamic> json) => Nave(
        codigo: json["Codigo"],
        nombre: json["Nombre"],
      );

  Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Nombre": nombre,
      };
}
