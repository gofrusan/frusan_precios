import 'package:flutter/material.dart';
import 'package:frusan_precios/src/helpers/dialog_helper.dart';
import 'package:frusan_precios/src/services/auth_service.dart';
import 'package:frusan_precios/src/shared/constants_shared.dart';
import 'package:frusan_precios/src/shared/dialog_shared.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

//import 'package:frusan_productores/src/pages/authenticate/register_page.dart';

class SignInPage extends StatefulWidget {
  final PlatformException exception;

  const SignInPage({Key key, this.exception}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  VideoPlayerController _controller;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<NavigatorState> _keyLoader = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset("assets/frusan/frusan.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setVolume(0.0);
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //textfields state
  String email = '';
  String password = '';

  /*Future<void> _onRegister(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => RegisterPage(),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color.fromRGBO(126, 192, 72, 1.0),
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            SizedBox.expand(
              child: FittedBox(
                // If your background video doesn't look right, try changing the BoxFit property.
                // BoxFit.fill created the look I was going for.
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size?.width ?? 0,
                  height: _controller.value.size?.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            Container(
              child: Image(
                  image: AssetImage("assets/frusan/logo_hero_frusan.png"),
                  width: mediaQuery.width * 0.5),
            ),
            _loginWidget(context)
          ],
        ));
  }

  Widget _loginWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _loginForm(context),
        SizedBox(height: 50.0),
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        width: mediaQuery.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              TextFormField(
                cursorColor: Color.fromRGBO(140, 128, 112, 1.0),
                decoration: textInputUserDecoration,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) =>
                    value.isEmpty ? "Ingresar un email" : null,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                cursorColor: Color.fromRGBO(140, 128, 112, 1.0),
                decoration: textInputPasswordDecoration,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: (value) =>
                    value.length < 6 ? "Ingresar una contraseña" : null,
              ),
              SizedBox(height: 20.0),
              ButtonTheme(
                minWidth: 300.0,
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Color.fromRGBO(126, 192, 72, 1.0),
                    child: Text(
                      'INGRESAR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => _submitForm(context)),
              ),
              /*FlatButton(
                onPressed: () => _onRegister(context), 
                textColor: Color.fromRGBO(126, 192, 72, 1.0),
                child: Text('No tiene cuenta? registrarse.')
                )*/
            ],
          ),
        ),
      ),
    );
  }

  _submitForm(BuildContext context) async {
    final _authService = Provider.of<AuthService>(context, listen: false);

    if (_formKey.currentState.validate()) {
      DialogsShared.showLoadingDialog(context, _keyLoader);
      final response =
          await _authService.signInWithEmailAndPassword(email, password);

      if (_keyLoader.currentContext != null)
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

      if (!response.exitoso)
        mostrarDialogoHelper(context, response.getCodigo, response.getMensaje);
    }
  }
}
