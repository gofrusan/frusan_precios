import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const textInputUserDecoration = InputDecoration(
  hintText: 'Usuario',
  icon: Icon(Icons.account_circle),
  labelText: 'Usuario',
  suffixIcon: Icon(Icons.accessibility),
);

const textInputPasswordDecoration = InputDecoration(
  hintText: 'Contraseña',
  icon: Icon(Icons.lock),
  labelText: 'Contraseña',
  suffixIcon: Icon(Icons.lock_open),
);

TextStyle textStyleTitlePage(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline5,
    color: Colors.white,
    fontWeight: FontWeight.w600);

TextStyle textStyleMenuDrawer(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline6,
    fontSize: 16.0,
    //color: Colors.black,
    fontWeight: FontWeight.w500);

TextStyle textStyleButtonGenerar(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.subtitle1,
    color: Colors.white,
    fontWeight: FontWeight.w600);

TextStyle textStyleButtonGuardar(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.subtitle1,
    color: Colors.white,
    fontWeight: FontWeight.w600);

TextStyle textStyleButtonCancelar(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.subtitle1,
    color: Colors.black,
    fontWeight: FontWeight.w600);

TextStyle textTitleStyleForm(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline6,
    color: Colors.black87,
    fontWeight: FontWeight.w600);

TextStyle dropHintStyleForm(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.subtitle1,
    color: Colors.grey[400],
    fontWeight: FontWeight.w400);

TextStyle dropHintStyleFormSelected(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.subtitle1,
    color: Colors.black87,
    fontWeight: FontWeight.w400);

TextStyle textTitleProcesoView(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline6,
    //color: Colors.black54,
    fontWeight: FontWeight.w900);

TextStyle textSubtitleProcesoView(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.subtitle1,
    //color: Colors.black54,
    fontWeight: FontWeight.w400);

TextStyle kilosPorcentajeHeaderLabelStyle(BuildContext context) =>
    GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline6,
        //fontSize: ScreenUtil().setSp(22, allowFontScalingSelf: true),
        fontWeight: FontWeight.w600);

TextStyle kilosPorcentajeHeaderStyle(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline6,
    fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
    color: Colors.white,
    fontWeight: FontWeight.w600);

TextStyle modalGridHeaderStyle(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline6,
    //fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
    fontWeight: FontWeight.w900);

TextStyle binsRecepcionadoTitleHeaderStyle(BuildContext context) =>
    GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline6,
        fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
        fontWeight: FontWeight.w700);

TextStyle binsRecepcionadoTitleSubtitleStyle(BuildContext context) =>
    GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline6,
        fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
        fontWeight: FontWeight.w400);

TextStyle modalGridBodyStyle(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline6,
    fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
    fontWeight: FontWeight.w600);

TextStyle modalGridBodyFooter(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline6,
    fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
    fontWeight: FontWeight.w900);

TextStyle modalGridBodyStylePlanta(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline6,
    fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
    color: Colors.white,
    fontWeight: FontWeight.w600);

TextStyle kilosPorcentajeBodyStyle(BuildContext context) => GoogleFonts.lato(
    textStyle: Theme.of(context).textTheme.headline6,
    //fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
    color: Colors.white,
    fontWeight: FontWeight.w900);

TextStyle kilosPorcentajeButtonDetalleStyle(BuildContext context) =>
    GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.caption,
        color: Colors.white,
        fontSize: ScreenUtil().setSp(17, allowFontScalingSelf: true),
        fontWeight: FontWeight.w600);

TextStyle kilosPorcentajeBodyLabelStyle(BuildContext context) =>
    GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.headline3,
        //fontSize: ScreenUtil().setSp(50, allowFontScalingSelf: true),
        color: Color(0xFF8CC63F),
        fontWeight: FontWeight.w900);

TextStyle recepcionesBodyStyle(BuildContext context) => TextStyle(
    fontSize: ScreenUtil().setSp(16, allowFontScalingSelf: true),
    fontFamily: Theme.of(context).textTheme.subtitle1.fontFamily,
    fontWeight: FontWeight.w500);

TextStyle subHeaderRecepcionesBodyStyle(BuildContext context) => TextStyle(
    fontSize: ScreenUtil().setSp(20, allowFontScalingSelf: true),
    fontFamily: Theme.of(context).textTheme.subtitle1.fontFamily,
    fontWeight: FontWeight.w900);

//____

Color verifyColorEspecie(int valor) {
  switch (valor) {
    case 9:
      return Color(0xFFF8D3D6);
      break;
    case 1:
      return Color(0xFFFBE3D3);
      break;
    case 22:
      return Color(0xFFFBE3D3);
      break;
    case 18:
      return Color(0xFFFEECB6);
      break;
    case 3:
      return Color(0xFFE4E3B0);
      break;
    case 23:
      return Color(0xFFDEE5F5);
      break;
    case 5:
      return Color(0xFFDECFE4);
      break;
    case 16:
      return Color(0xFFDECFE4);
      break;
    case 4:
      return Color(0xFFD6E6B8);
      break;
    case 15:
      return Color(0xFFD1D7E5);
      break;
    case 19:
      return Color(0xFFD1D7E5);
      break;
    case 12:
      return Color(0xFFFADDAF);
      break;
    case 2:
      return Color(0xFFF6D5E0);
      break;
    case 14:
      return Color(0xFFFFDCC6);
      break;
    default:
      return Color(0xFFE6F0CD);
      break;
  }
}

//___

Color verifyColorEspecieGrid(int valor) {
  switch (valor) {
    case 9:
      return Color(0xFFEA7C85);
      break;
    case 1:
      return Color(0xFFCC7A7F);
      break;
    case 22:
      return Color(0xFFCC7A7F);
      break;
    case 18:
      return Color(0xFFA9D46F);
      break;
    case 3:
      return Color(0xFFC5C564);
      break;
    case 23:
      return Color(0xFF849ECB);
      break;
    case 5:
      return Color(0xFF9D71AE);
      break;
    case 16:
      return Color(0xFF9D71AE);
      break;
    case 4:
      return Color(0xFF9AC059);
      break;
    case 15:
      return Color(0xFF849ECB);
      break;
    case 19:
      return Color(0xFF849ECB);
      break;
    case 12:
      return Color(0xFFF4B656);
      break;
    case 2:
      return Color(0xFFE78BA9);
      break;
    case 14:
      return Color(0xFFF1A76B);
      break;
    default:
      return Color(0xFFE6F0CD);
      break;
  }
}

//____

AssetImage verifyImagenEspecie(int valor) {
  switch (valor) {
    case 9:
      return AssetImage('assets/frusan/cerezas_back.png');
      break;
    case 1:
      return AssetImage('assets/frusan/manzanas_back.png');
      break;
    case 22:
      return AssetImage('assets/frusan/manzanas_back.png');
      break;
    case 18:
      return AssetImage('assets/frusan/membrillos_back.png');
      break;
    case 3:
      return AssetImage('assets/frusan/peras_back.png');
      break;
    case 23:
      return AssetImage('assets/frusan/haskap_back.png');
      break;
    case 5:
      return AssetImage('assets/frusan/ciruelas_back.png');
      break;
    case 16:
      return AssetImage('assets/frusan/ciruelas_back.png');
      break;
    case 4:
      return AssetImage('assets/frusan/kiwis_back.png');
      break;
    case 15:
      return AssetImage('assets/frusan/arandanos_back.png');
      break;
    case 19:
      return AssetImage('assets/frusan/arandanos_back.png');
      break;
    case 12:
      return AssetImage('assets/frusan/clementinas_back.png');
      break;
    case 2:
      return AssetImage('assets/frusan/uvas_back.png');
      break;
    case 14:
      return AssetImage('assets/frusan/mandarinas_back.png');
      break;
    default:
      return AssetImage('assets/frusan/generico_back.png');
      break;
  }
}
