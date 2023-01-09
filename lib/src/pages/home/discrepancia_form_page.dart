import 'package:animations/animations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:frusan_precios/src/services/precios_propuestos_services.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

import 'package:frusan_precios/src/services/precios_service.dart';
import 'package:frusan_precios/src/shared/constants_shared.dart';
import 'package:frusan_precios/src/helpers/error_stream.dart';
import 'package:frusan_precios/src/editable/editable.dart';
//import 'package:frusan_precios/src/models/form_precio_view.dart';
import 'package:frusan_precios/src/utils/utils.dart';
import 'package:frusan_precios/src/helpers/comma_text_input_formatter.dart';

class DiscrepanciaFormPage extends StatefulWidget {
  @override
  _DiscrepanciaFormPageState createState() => _DiscrepanciaFormPageState();
}

class _DiscrepanciaFormPageState extends State<DiscrepanciaFormPage> {
  Widget _form;

  //final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  // form key
  final _formKey = GlobalKey<FormState>();

  /// Create a Key for EditableState
  final _editableKey = GlobalKey<EditableState>();
  final _keyPropuestos = GlobalKey();

  ///Print only edited rows.
  /*void _printEditedRows() {
    List editedRows = _editableKey.currentState.editedRows;
    print(editedRows);

    print(_editableKey.currentState.rowCount);
  }*/

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    _formKey.currentState?.reset();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_form == null) {
      _form = _createForm(context);
    }

    return _form;
  }

  //Verificar o borrar
  Widget _createForm(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(10.0))),
          title: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Text('Completar Precios',
                textAlign: TextAlign.center,
                style: textStyleTitlePage(context)),
          ),
          /*actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () => _printEditedRows(),
                  child: Text('Edited Rows',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            )
          ],*/
        ),
        floatingActionButton: Container(
          width: double.infinity,
          child: FloatingActionButton.extended(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            label: Text(
              'Enviar Precios',
              style: textStyleButtonGenerar(context),
            ),
            icon: Icon(Icons.send),
            backgroundColor: Theme.of(context).primaryColor,
            tooltip: 'Enviar precios',
            onPressed: () => enviarInformacionPrecios(context),
          ),
        ),
        body: SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _createPrecioForm(context),
            SizedBox(height: 30.0),
            Flexible(
                child: Container(
              child: _createPrecioTable(context),
              constraints: BoxConstraints(
                  maxHeight: mediaQuery.height * 0.68,
                  maxWidth: mediaQuery.width),
            )),
          ],
        )),
      ),
    );
  }

  //______

  Future<void> enviarInformacionPrecios(BuildContext context) async {
    {
      final _precioService =
          Provider.of<VistaPrecioService>(context, listen: false);

      final answer = await showOkCancelAlertDialog(
          context: context,
          title: 'Confirmación',
          message:
              'La lista de precios será enviada para su modificación. Esta seguro...?',
          okLabel: 'Enviar',
          cancelLabel: 'Cancelar',
          barrierDismissible: false,
          style: AdaptiveStyle.adaptive);

      if (answer == OkCancelResult.ok) {
        List editedRows = _editableKey.currentState.editedRows;

        Dialogs.showLoadingUIBlock(context, "Cargando...");

        try {
          await _precioService.setearListaVistaPrecios(editedRows);
          Dialogs.hideLoadingUIBlock(context);

          var okResponseCorrect = await showOkAlertDialog(
              context: context,
              style: AdaptiveStyle.adaptive,
              okLabel: 'ok',
              barrierDismissible: false,
              message:
                  'Los datos de lo precios fueron modificados exitosamente.',
              title: 'Mensaje');

          if (okResponseCorrect == OkCancelResult.ok) {
            Navigator.of(context).pop();
          }
        } catch (e) {
          Dialogs.hideLoadingUIBlock(context);

          var okResponseIncorrect = await showOkAlertDialog(
              context: context,
              style: AdaptiveStyle.adaptive,
              okLabel: 'ok',
              barrierDismissible: false,
              message:
                  'Se produjo un error al tratar de modificar los datos de los precios.',
              title: 'Mensaje Error');

          if (okResponseIncorrect == OkCancelResult.ok) {
            Navigator.of(context).pop();
          }
        }
      }
    }
  }

  //_____

  //Método que crea el precio form
  Widget _createPrecioForm(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    final propiedadGuardar =
        Provider.of<FormPrecioView>(context, listen: false);

    return Container(
      width: mediaQuery.width,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                width: 120.0,
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?[\,.]?\d{0,2}')),
                    CommaTextInputFormatter()
                  ],
                  decoration: InputDecoration(
                      hintText: '0.0',
                      icon: Icon(Icons.confirmation_number),
                      labelText: 'Precio'),
                  cursorColor: Color.fromRGBO(140, 128, 112, 1.0),
                  onChanged: (value) {
                    propiedadGuardar.valorPrecio = double.tryParse(value);
                  },
                  validator: (value) =>
                      value.isEmpty ? "Ingrese un precio" : null,
                ),
              ),
            ),            
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: Container(
                width: 110.0,
                child: ButtonTheme(
                  //minWidth: 100.0,
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Color.fromRGBO(126, 192, 72, 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Copiar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil()
                                    .setSp(16, allowFontScalingSelf: true),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.content_copy,
                            size: ScreenUtil().setWidth(16),
                          )
                        ],
                      ),
                      onPressed: () => _submitForm(context)),
                ),
              ),
            ),
            
            Flexible(
              flex: 3,
              fit: FlexFit.loose,
              child: Container(
                width: 140.0,
                child: ButtonTheme(
                  //minWidth: 100.0,
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Color.fromRGBO(126, 192, 72, 1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Propuestos',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil()
                                    .setSp(16, allowFontScalingSelf: true),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.priority_high_sharp,
                            size: 16,
                          )
                        ],
                      ),
                      onPressed: () => _showDialogPropuestos(context)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //____

  _showDialogPropuestos(BuildContext parentContext) async {
    final propiedadGuardar =
        Provider.of<FormPrecioView>(context, listen: false);

    final vistaPrecioService =
        Provider.of<VistaPrecioService>(context, listen: false);

    return showModal(
      context: parentContext,
      configuration: FadeScaleTransitionConfiguration(
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(parentContext).modalBarrierDismissLabel,
          barrierColor: Colors.black.withOpacity(0.7),
          transitionDuration: const Duration(milliseconds: 500)),
      builder: (BuildContext context) {
        return SafeArea(
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey.withOpacity(0.7)),
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height - 80,
              padding: EdgeInsets.all(5.0),
              //color: Colors.redAccent,
              child: Column(children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close, size: ScreenUtil().setWidth(25)),
                  shape: CircleBorder(),
                  color: Colors.lightGreen.shade700,
                ),
                SizedBox(height: 10),
                Expanded(
                    child: Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(15.0)),
                  ),
                  child: _createEditableTableFormat(
                      false,
                      propiedadGuardar.jsonColumnasPropuestas,
                      propiedadGuardar.jsonFilasPropuestas),
                )),
                MaterialButton(
                  onPressed: () async {
                    try {
                      Dialogs.showLoadingUIBlock(context, "Cargando...");

                      _formKey.currentState.reset();                      

                      await vistaPrecioService
                          .obtenerListaVistaPreciosPropuestos(propiedadGuardar);

                      Dialogs.hideLoadingUIBlock(context);

                      Navigator.of(context, rootNavigator: true).pop();
                    } catch (e) {
                      showOkAlertDialog(
                          context: context,
                          style: AdaptiveStyle.adaptive,
                          okLabel: 'ok',
                          message: '$e',
                          title: 'Mensaje Error');
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Copiar Propuestos',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil()
                                .setSp(16, allowFontScalingSelf: true),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(
                        Icons.content_copy,
                        size: ScreenUtil().setWidth(25),
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Color.fromRGBO(126, 192, 72, 1.0),
                )
              ]),
            ),
          ),
        );
      },
    );

    /*if (await confirm(context,
        title: Text('Confirm'),
        content: _createEditableTableFormat(
            false,
            propiedadGuardar.jsonColumnasPropuestas,
            propiedadGuardar.jsonFilasPropuestas),
        textOK: Text('Yes'),
        textCancel: Text('No'))) {
    } else {}*/
  }

  //_____

  _submitForm(BuildContext context) async {
    try {
      if (_formKey.currentState.validate()) {
        Dialogs.showLoadingUIBlock(context, "Cargando...");

        _formKey.currentState.reset();

        final _vistaPrecioService =
            Provider.of<VistaPrecioService>(context, listen: false);

        final propiedadGuardar =
            Provider.of<FormPrecioView>(context, listen: false);

        await _vistaPrecioService.obtenerListaVistaPrecios(propiedadGuardar);

        Dialogs.hideLoadingUIBlock(context);
      }
    } catch (e) {
      showOkAlertDialog(
          context: context,
          style: AdaptiveStyle.adaptive,
          okLabel: 'ok',
          message: '$e',
          title: 'Mensaje Error');
    }
  }

  //______

  //Método que crea la tabla editable
  Widget _createPrecioTable(BuildContext context) {
    final _vistaPrecioService =
        Provider.of<VistaPrecioService>(context, listen: false);

    final propiedadGuardar =
        Provider.of<FormPrecioView>(context, listen: false);

    _vistaPrecioService.obtenerListaVistaPrecios(propiedadGuardar);

    return StreamBuilder(
      stream: _vistaPrecioService.vistaPrecioStream,
      builder: (BuildContext context, AsyncSnapshot<VistaPrecio> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final listaDatos = snapshot.hasData ? snapshot.data : VistaPrecio();

          final jsonColumnas = listaDatos.valorColumnas.toJson();
          final jsonFilas = listaDatos.valorFilas.toJson();
          final jsonColumnasPropuestas =
              listaDatos.valorColumnasPropuestas.toJson();
          final jsonFilasPropuestas = listaDatos.valorFilasPropuestas.toJson();

          if (_editableKey.currentState != null)
            _editableKey.currentState.columns = jsonColumnas["Data"];

          if (_editableKey.currentState != null)
            _editableKey.currentState.rows = jsonFilas["Data"];

          validarErroresStream(snapshot, context, listaDatos.valorColumnas);
          validarErroresStream(snapshot, context, listaDatos.valorFilas);

          propiedadGuardar.jsonColumnasPropuestas =
              jsonColumnasPropuestas["Data"];
          propiedadGuardar.jsonFilasPropuestas = jsonFilasPropuestas["Data"];

          return _createEditableTableFormat(
              true, jsonColumnas["Data"], jsonFilas["Data"]);
        }

        return Center(
            child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        ));
      },
    );
  }

  //_____ editable table

  Widget _createEditableTableFormat(
      bool editable, List<dynamic> jsonColumnas, List<dynamic> jsonFilas) {
    return Editable(
      key: editable ? _editableKey : _keyPropuestos,
      columns: jsonColumnas,
      rows: jsonFilas,
      zebraStripe: true,
      stripeColor1: Color(0xFFE8F4D9),
      stripeColor2: Color(0xFFE7E7E7),
      onRowSaved: (value) {
        print(value);
      },
      onSubmitted: (value) {
        print(value);
      },
      borderColor: Colors.blueGrey,
      tdStyle: TextStyle(fontWeight: FontWeight.bold),
      trHeight: 80,
      thStyle: TextStyle(
          fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true),
          fontWeight: FontWeight.bold),
      thAlignment: TextAlign.center,
      thVertAlignment: CrossAxisAlignment.end,
      thPaddingBottom: 3,
      showSaveIcon: false,
      saveIconColor: Colors.black,
      showCreateButton: false,
      tdAlignment: TextAlign.left,
      tdEditableMaxLines: 100, // don't limit and allow data to wrap
      tdPaddingTop: 0,
      tdPaddingBottom: 14,
      tdPaddingLeft: 10,
      tdPaddingRight: 8,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(0))),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
