import 'package:flutter/material.dart';

Future mostrarDialogoHelper(
    BuildContext context, String titulo, String contenido) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.brown[100],
          title: Text(titulo),
          content: Text(contenido),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'))
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        );
      });
}
