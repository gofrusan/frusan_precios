import 'dart:convert';

FilaPrecio filaPrecioFromJson(String str) =>
    FilaPrecio.fromJson(json.decode(str));

String filaPrecioToJson(FilaPrecio data) => json.encode(data.toJson());

class FilasPrecios {
  List<FilaPrecio> data = [];
  String error;
  dynamic code;

  FilasPrecios();

  FilasPrecios.fromParameters({
    this.data,
    this.error,
    this.code,
  });

  factory FilasPrecios.fromJson(Map<String, dynamic> json) =>
      FilasPrecios.fromParameters(
        data: json["Data"] == null
            ? []
            : List<FilaPrecio>.from(
                json["Data"].map((x) => FilaPrecio.fromJson(x))),
        error: json["Error"],
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Error": error,
        "Code": code,
      };
}

///List rows = [
///          {"name": 'James Joe', "date":'23/09/2020',"month":'June',"status":'completed'},
///          {"name": 'Daniel Paul', "date":'12/4/2020',"month":'March',"status":'new'},
///        ];

class FilaPrecio {
  int id;
  String codigoNave;
  String descripcion;
  double precio;

  FilaPrecio({this.id, this.codigoNave, this.descripcion, this.precio});

  factory FilaPrecio.fromJson(Map<String, dynamic> json) => FilaPrecio(
      id: json["Id"], codigoNave: json["CodigoNave"], descripcion: json["Descripcion"], precio: json["Precio"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "codigoNave" : codigoNave, "descripcion": descripcion, "precio": precio};
}
