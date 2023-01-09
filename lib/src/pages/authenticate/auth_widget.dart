import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:frusan_precios/src/models/user_model.dart';
import 'package:frusan_precios/src/pages/authenticate/sign_in_page.dart';
import 'package:frusan_precios/src/pages/home/home_page.dart';

///Build the signed-in or non signed-in UI, depending on the user snapshot.
///This widget should be below the [MaterialApp]
///An [AuthWidgetBuilder] ancestor is required for this widget to work
class AuthWidget extends StatelessWidget {
  final AsyncSnapshot<UserInside> userSnapshot;

  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    ScreenUtil.init(context,
        width: size.width, height: size.height, allowFontScaling: true);

    //final _authService = Provider.of<AuthService>(context);

    //print('StreamBuilder: ${userSnapshot.connectionState}');
    // print('StreamBuilder: ${userSnapshot.hasData}');

    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomePage() : SignInPage();
    }

    return Scaffold(body: Center(child: CircularProgressIndicator()));

    /*return StreamBuilder(
      stream: _authService.cargandoStream,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                
        if (snapshot.hasData) {          
          if (snapshot.data) return LoadingShared();
        }

        if(snapshot.hasError){
          final snapshotError = snapshot.error as PlatformException;

          return SignInPage(exception: snapshotError);          
        }

        if (userSnapshot.connectionState == ConnectionState.active) {
          return userSnapshot.hasData ? HomePage() : SignInPage();
        }

        return LoadingShared(); //Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );*/
  }
}
