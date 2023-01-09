import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogsShared {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: Container(
                key: key,
                child: Overlay(
                  initialEntries: [
                    OverlayEntry(builder: (BuildContext context) {
                      return Container(
                        color: Color.fromRGBO(126, 192, 72, 1.0),
                        child: Center(
                            child: SpinKitChasingDots(
                                color: Colors.lightGreen[900], size: 50.0)),
                      );
                    })
                  ],
                ),
              ));
        });
  }
}
