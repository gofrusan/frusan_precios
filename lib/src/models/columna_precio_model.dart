import 'dart:convert';

ColumnaPrecio columnaPrecioFromJson(String str) =>
    ColumnaPrecio.fromJson(json.decode(str));

String columnaPrecioToJson(ColumnaPrecio data) => json.encode(data.toJson());

class ColumnasPrecios {
  List<ColumnaPrecio> data = [];
  String error;
  dynamic code;

  ColumnasPrecios();

  ColumnasPrecios.fromParameters({
    this.data,
    this.error,
    this.code,
  });

  factory ColumnasPrecios.fromJson(Map<String, dynamic> json) =>
      ColumnasPrecios.fromParameters(
        data: json["Data"] == null
            ? []
            : List<ColumnaPrecio>.from(
                json["Data"].map((x) => ColumnaPrecio.fromJson(x))),
        error: json["Error"],
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
        "Error": error,
        "Code": code,
      };
}

/// List cols = [
///   {"title":'Name', 'widthFactor': 0.1, 'key':'name', 'editable': false},
///   {"title":'Date', 'widthFactor': 0.2, 'key':'date'},
///   {"title":'Month', 'widthFactor': 0.1, 'key':'month', 'editable': false},
///   {"title":'Status', 'widthFactor': 0.1, 'key':'status'},
/// ];

class ColumnaPrecio {
  String title;
  double widthFactor;
  String key;
  bool editable;
  bool visible;

  ColumnaPrecio({this.title, this.widthFactor, this.key, this.editable, this.visible});

  factory ColumnaPrecio.fromJson(Map<String, dynamic> json) => ColumnaPrecio(
        title: json["title"],
        widthFactor: json["widthFactor"],
        key: json["key"],
        editable: json["editable"],
        visible : json["visible"]
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "widthFactor": widthFactor,
        "key": key,
        "editable": editable,
        "visible" : visible
      };
}
