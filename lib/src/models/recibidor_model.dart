import 'dart:convert';

Recibidor recibidorFromJson(String str) => Recibidor.fromJson(json.decode(str));

String recibidorToJson(Recibidor data) => json.encode(data.toJson());

class Recibidores {
  List<Recibidor> data = [];
  String error;
  dynamic code;

  Recibidores();

  Recibidores.fromParameters({
    this.data,
    this.error,
    this.code,
  });

  factory Recibidores.fromJson(Map<String, dynamic> json) =>
      Recibidores.fromParameters(
        data: json["Data"] == null
            ? []
            : List<Recibidor>.from(
                json["Data"].map((x) => Recibidor.fromJson(x))),
        error: json["Error"],
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Error": error,
        "Code": code,
      };
}

class Recibidor {
  Recibidor({
    this.codigo,
    this.nombre,
  });

  int codigo;
  String nombre;

  factory Recibidor.fromJson(Map<String, dynamic> json) => Recibidor(
        codigo: json["Codigo"],
        nombre: json["Nombre"],
      );

  Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Nombre": nombre,
      };
}
