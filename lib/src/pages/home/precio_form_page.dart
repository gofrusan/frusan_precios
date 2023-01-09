import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frusan_precios/src/services/precios_propuestos_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:frusan_precios/src/globals/drop_down_form_precios.dart';
import 'package:frusan_precios/src/helpers/error_stream.dart';
import 'package:frusan_precios/src/services/precios_service.dart';
import 'package:frusan_precios/src/models/form_values.dart';
import 'package:frusan_precios/src/services/recibidor_service.dart';
//import 'package:frusan_precios/src/services/nave_service.dart';
import 'package:frusan_precios/src/pages/home/discrepancia_form_page.dart';
import 'package:frusan_precios/src/shared/constants_shared.dart';
import 'package:frusan_precios/src/globals/menu_widget.dart';
import 'package:frusan_precios/src/models/user_model.dart';
//import 'package:frusan_precios/src/models/form_precio_view.dart';

class PrecioFormPage extends StatefulWidget {
  @override
  _PrecioFormPageState createState() => _PrecioFormPageState();
}

class _PrecioFormPageState extends State<PrecioFormPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    final propiedadGuardar =
        Provider.of<FormPrecioView>(context, listen: false);

    propiedadGuardar.valorRecibidor = null;
    propiedadGuardar.valorNave = null;

    _fbKey.currentState?.reset();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final propiedadGuardar =
        Provider.of<FormPrecioView>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        drawer: MenuWidget(),
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(20.0))),
          title: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Text(
              'Completar Precios',
              textAlign: TextAlign.center,
              style: textStyleTitlePage(context),
            ),
          ),
        ),
        floatingActionButton: Container(
          width: double.infinity,
          child: FloatingActionButton.extended(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            label: Text(
              'Generar',
              style: textStyleButtonGenerar(context),
            ),
            icon: Icon(Icons.graphic_eq),
            backgroundColor: Theme.of(context).primaryColor,
            tooltip: 'Discrepancia Precios',
            onPressed: () {
              if (_fbKey.currentState.validate()) {
                _fbKey.currentState.save();
                _fbKey.currentState.reset();

                _showDiscrepanciaPrecioDialog(context, propiedadGuardar);
              }
            },
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(10.0)),
              FormBuilder(
                  initialValue: {
                    'recibidor': propiedadGuardar.valorRecibidor,
                    'nave': propiedadGuardar.valorNave
                  },
                  key: _fbKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(children: <Widget>[
                    _dropDownRecibidores(context),
                    //_dropDownNave(context)
                  ]))
            ]),
          ),
        ));
  }

  //___

  Future<void> _showDiscrepanciaPrecioDialog(
      BuildContext parentContext, FormPrecioView formView) async {
    formView.valorPrecio = null;

    await Navigator.of(context).push(
      MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => MultiProvider(providers: [
                Provider.value(value: formView),
                Provider(create: (context) => VistaPrecioService()),
                Provider(create: (context) => VistaPrecioPropuestoService()),
              ], child: DiscrepanciaFormPage()),
          settings: RouteSettings(arguments: 'Desde Submit')),
    );

    setState(() {
      _fbKey.currentState.reset();
      formView.valorRecibidor = null;
      formView.valorNave = null;
    });
  }

  //____

  _dropDownRecibidores(BuildContext context) {
    final _user = Provider.of<UserInside>(context, listen: false);

    final _recibidorService =
        Provider.of<RecibidorService>(context, listen: false);
    //final _naveService = Provider.of<NaveService>(context, listen: false);

    final propiedadGuardar =
        Provider.of<FormPrecioView>(context, listen: false);

    //final propiedadMenu = Provider.of<MenuView>(context);

    return FutureBuilder<Recibidores>(
        future: _recibidorService
            .obtenerListaDiscrepanciaPrecioRecibidores(_user.segUsrId),
        builder: (BuildContext context, AsyncSnapshot<Recibidores> snapshot) {
          /*if (!snapshot.hasData && !snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }*/

          final listaDatos = snapshot.hasData ? snapshot.data : Recibidores();

          validarErroresStream(snapshot, context, listaDatos);

          final listaDropValues = listaDatos.data
              .map((recibidor) => DropDownValueInt(
                  valor: recibidor.codigo, texto: recibidor.nombre))
              .toList();

          return FormBuilderField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: 'Campo requerido...')
              ]),
              onSaved: (value) {
                propiedadGuardar?.valorRecibidor = value;
              },
              name: "recibidor",
              builder: DropDownFormPrecioRecibidorInt(
                  readOnly: false,
                  listaDatos: listaDropValues,
                  propiedadGuardar: propiedadGuardar,
                  titulo: "Recibidor",
                  callback: (propiedadGuardar) {
                    /*_naveService.obtenerListaDiscrepanciaPrecioNavesEmpty();

                    if (_fbKey.currentState.fields['nave'] != null)
                      _fbKey.currentState.fields['nave'].reset();

                    _naveService.obtenerListaDiscrepanciaPrecioNaves(
                        propiedadGuardar.valorRecibidor);*/
                  },
                  onSaved: (value) {
                    propiedadGuardar?.valorRecibidor = value;
                  }).builder);
        });
  }

  //_____

  /*_dropDownNave(BuildContext context) {
    final _naveService = Provider.of<NaveService>(context, listen: false);

    final propiedadGuardar =
        Provider.of<FormPrecioView>(context, listen: false);

    _naveService
        .obtenerListaDiscrepanciaPrecioNaves(propiedadGuardar.valorRecibidor);

    return StreamBuilder<Naves>(
        stream: _naveService.naveStream,
        builder: (BuildContext context, AsyncSnapshot<Naves> snapshot) {
          /*if (!snapshot.hasData && !snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }*/

          final listaDatos = snapshot.hasData ? snapshot.data : Naves();

          validarErroresStream(snapshot, context, listaDatos);

          final listaDropValues = listaDatos.data
              .map((nave) =>
                  DropDownValueString(valor: nave.codigo, texto: nave.nombre))
              .toList();

          return FormBuilderField(
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context,
                    errorText: 'Campo requerido...')
              ]),
              onSaved: (value) {
                propiedadGuardar?.valorNave = value;
              },
              name: 'nave',
              builder: DropDownFormPrecioNaveString(
                  readOnly: false,
                  listaDatos: listaDropValues,
                  propiedadGuardar: propiedadGuardar,
                  titulo: 'Nave',
                  callback: (propiedadGuardar) {},
                  onSaved: (value) {
                    propiedadGuardar?.valorNave = value;
                  }).builder);
        });
  }*/
}
