import 'package:flutter/material.dart';

void validarErroresStream(
    AsyncSnapshot snapshot, BuildContext context, dynamic listaDatos) {
  if (snapshot.hasError) {
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(snapshot.error))));
  }

  if (listaDatos.error != null) {
    if (listaDatos.error.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(listaDatos.error))));
    }
  }
}
