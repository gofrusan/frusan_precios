import 'dart:convert';

Usuarios usuariosFromJson(String str) => Usuarios.fromJson(json.decode(str));

String usuariosToJson(Usuarios data) => json.encode(data.toJson());

class Usuarios {
  Usuario data;
  String error;
  dynamic code;

  Usuarios();

  Usuarios.fromParameters({
    this.data,
    this.error,
    this.code,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) =>
      Usuarios.fromParameters(
        data: json["Data"] == null
            ? null
            : Usuario.fromJson(json["Data"]),
        error: json["Error"],
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
        "Error": error,
        "Code": code,
    };
}

class Usuario {
    Usuario({
        this.id,
        this.nombre        
    });

    String id;
    String nombre;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["Id"],
        nombre: json["Nombre"]
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Nombre": nombre
    };
}


