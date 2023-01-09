//import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frusan_precios/src/services/usuario_service.dart';
import 'package:frusan_precios/src/helpers/error_stream.dart';
import 'package:frusan_precios/src/services/auth_service.dart';
import 'package:frusan_precios/src/globals/menu_widget.dart';
import 'package:frusan_precios/src/shared/constants_shared.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context, listen: false);
    final _user = Provider.of<UserInside>(context, listen: false);

    var mediaQuerySize = MediaQuery.of(context).size;

    ScreenUtil.init(context,
        width: mediaQuerySize.width,
        height: mediaQuerySize.height,
        allowFontScaling: true);

    var mainTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      drawer: MenuWidget(),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0))),
        title: Container(
          width: MediaQuery.of(context).size.width * 0.65,
          child: Text(
            'Inicio',
            textAlign: TextAlign.center,
            style: textStyleTitlePage(context),
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.black54,
              ),
              label: Text(
                'Logout',
                style: GoogleFonts.lato(
                    textStyle: mainTheme.headline6,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400),
              )),
          /*FlatButton.icon(
                  onPressed: () => _showSettingsPanel(context),
                  icon: Icon(Icons.settings),
                  label: Text('settings'))*/
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: mediaQuerySize.height * 0.2,
          ),
          Container(
            height: mediaQuerySize.height * 0.2,
            width: mediaQuerySize.width,
            decoration: new BoxDecoration(
              color: Colors.transparent,
              image: new DecorationImage(
                fit: BoxFit.fitHeight,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(1), BlendMode.dstATop),
                image: AssetImage(
                  'assets/frusan/logo_footer.png',
                ),
              ),
            ),
          ),
          SizedBox(
            height: mediaQuerySize.height * 0.15,
          ),
          Container(
            child: _usuarioBienvenida(context, _user, mainTheme),
          )
        ],
      ),
    );
  }

  Widget _usuarioBienvenida(
      BuildContext context, UserInside user, TextTheme mainTheme) {
    final _usuarioService = Provider.of<UsuarioService>(context, listen: false);

    var mainTheme = Theme.of(context).textTheme;

    return FutureBuilder<Usuarios>(
      future: _usuarioService.obtenerInfoUsuarioNombrePorUId(user.uid),
      builder: (BuildContext context, AsyncSnapshot<Usuarios> snapshot) {
        if (!snapshot.hasData && !snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }

        final infoUsuario = snapshot.hasData ? snapshot.data : Usuarios();

        validarErroresStream(snapshot, context, infoUsuario);

        user.segUsrId = infoUsuario.data?.id;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Hola',
                  style: GoogleFonts.lato(
                      textStyle: mainTheme.headline2,
                      color: Colors.lightGreen[600],
                      fontWeight: FontWeight.w400)),
              SizedBox(height: 5),
              Text(
                '${infoUsuario.data?.nombre}',
                style: GoogleFonts.lato(
                    textStyle: mainTheme.headline3,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        );
      },
    );
  }
}
