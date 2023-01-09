import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:frusan_precios/src/models/form_precio_view.dart';

import 'package:frusan_precios/src/models/form_values.dart';
import 'package:frusan_precios/src/shared/constants_shared.dart';

class DropDownFormPrecioRecibidorInt extends FormField<int> {
  DropDownFormPrecioRecibidorInt(
      {List<DropDownValueInt> listaDatos,
      String titulo,
      FormPrecioView propiedadGuardar,
      IconData icono,
      bool readOnly,
      FormFieldSetter<int> onSaved,
      Function(FormPrecioView) callback})
      : super(
            onSaved: onSaved,
            enabled: readOnly,
            builder: (FormFieldState<int> state) {
              var mainTheme = Theme.of(state.context);

              return InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 7.0),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelText: titulo,
                  labelStyle: textTitleStyleForm(state.context),
                  errorText: state.errorText,
                ),
                isEmpty: propiedadGuardar == null,
                child: Container(
                  margin: EdgeInsets.only(top: 5.0),
                  height: ScreenUtil().setHeight(40.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.transparent,
                      border: Border.all(width: 0.5)),
                  child: new DropdownButtonHideUnderline(
                    child: new DropdownButton<int>(
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Seleccionar ...',
                            style: dropHintStyleForm(state.context)),
                      ),
                      isExpanded: true,
                      icon: Container(
                        height: ScreenUtil().setHeight(40.0),
                        width: ScreenUtil().setHeight(30.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0.0),
                            color: listaDatos.length <= 0
                                ? Colors.grey[300]
                                : mainTheme.primaryColor),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                      iconEnabledColor: mainTheme.primaryColor,
                      value: propiedadGuardar.valorRecibidor,
                      isDense: true,
                      onChanged: (int newValue) {
                        propiedadGuardar?.valorRecibidor = newValue;
                        propiedadGuardar?.valorNave = null;
                        
                        state.didChange(newValue);
                        state.validate();
                        if (callback != null) callback(propiedadGuardar);
                      },
                      items: listaDatos.map((DropDownValueInt objectInt) {
                        return new DropdownMenuItem<int>(
                          value: objectInt.valor,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: new Text(
                              '${objectInt.valor} - ${objectInt.texto}',
                              overflow: TextOverflow.ellipsis,
                              style: dropHintStyleFormSelected(state.context),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            });
}

class DropDownFormPrecioNaveString extends FormField<String> {
  DropDownFormPrecioNaveString(
      {List<DropDownValueString> listaDatos,
      String titulo,
      FormPrecioView propiedadGuardar,
      IconData icono,
      bool readOnly,
      FormFieldSetter<String> onSaved,
      Function(FormPrecioView) callback})
      : super(
            onSaved: onSaved,
            enabled: readOnly,
            builder: (FormFieldState<String> state) {
              var mainTheme = Theme.of(state.context);

              return InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 7.0),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  labelText: titulo,
                  labelStyle: textTitleStyleForm(state.context),
                  errorText: state.errorText,
                ),
                isEmpty: propiedadGuardar == null,
                child: Container(
                  margin: EdgeInsets.only(top: 5.0),
                  height: ScreenUtil().setHeight(40.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.transparent,
                      border: Border.all(width: 0.5)),
                  child: new DropdownButtonHideUnderline(
                    child: new DropdownButton<String>(
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Seleccionar ...',
                            style: dropHintStyleForm(state.context)),
                      ),
                      isExpanded: true,
                      icon: Container(
                        height: ScreenUtil().setHeight(40.0),
                        width: ScreenUtil().setHeight(30.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0.0),
                            color: listaDatos.length <= 0
                                ? Colors.grey[300]
                                : mainTheme.primaryColor),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                      iconEnabledColor: mainTheme.primaryColor,
                      value: propiedadGuardar.valorNave,
                      isDense: true,
                      onChanged: (String newValue) {
                        propiedadGuardar?.valorNave = newValue;                       
                        state.didChange(newValue);
                        state.validate();
                        if (callback != null) callback(propiedadGuardar);
                      },
                      items: listaDatos.map((DropDownValueString objectInt) {
                        return new DropdownMenuItem<String>(
                          value: objectInt.valor,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: new Text(
                              '${objectInt.valor} - ${objectInt.texto}',
                              overflow: TextOverflow.ellipsis,
                              style: dropHintStyleFormSelected(state.context),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            });
}