import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uiblock/uiblock.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black45,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }

  //______

  static void showLoadingUIBlock(BuildContext context, String loadingText) {
    UIBlock.block(context,
        backgroundColor: Colors.lightGreen.withOpacity(0.5),
        imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        childBuilder: (context) {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text(
            loadingText,
            style: TextStyle(color: Colors.black87, fontSize: 25.0),
          )
        ]),
      );
    });
  }

  static void hideLoadingUIBlock(BuildContext context) {
    UIBlock.unblock(context);
  }
}
