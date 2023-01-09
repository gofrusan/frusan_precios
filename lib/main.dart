import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:frusan_precios/src/pages/authenticate/auth_widget_builder.dart';
import 'package:frusan_precios/src/pages/authenticate/auth_widget.dart';
import 'package:frusan_precios/src/services/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error);
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
                providers: [
                  Provider<AuthService>(create: (_) => AuthService())
                ],
                child: AuthWidgetBuilder(builder: (context, snapshot) {
                  return MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: ThemeData(
                        /*pageTransitionsTheme: PageTransitionsTheme(
                    builders: {
                      TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                          transitionType: SharedAxisTransitionType.scaled,
                        ),
                        TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
                          transitionType: SharedAxisTransitionType.scaled,                        
                        ),
                    }
                  ),*/
                      appBarTheme: AppBarTheme(
                            backgroundColor: Color.fromRGBO(126, 192, 72, 1.0)),
                        primaryColor: Color.fromRGBO(126, 192, 72, 1.0),
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary:
                                  Color.fromRGBO(126, 192, 72, 1.0), // NEW WAY
                            ),
                      ),
                      title: 'Frusan Movil Precios',
                      home: AuthWidget(userSnapshot: snapshot));
                }));
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
