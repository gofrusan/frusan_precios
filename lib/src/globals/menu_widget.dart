import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:frusan_precios/src/services/nave_service.dart';
import 'package:frusan_precios/src/services/precios_propuestos_services.dart';
import 'package:provider/provider.dart';

import 'package:frusan_precios/src/services/recibidor_service.dart';
import 'package:frusan_precios/src/pages/home/precio_form_page.dart';
import 'package:frusan_precios/src/services/precios_service.dart';
import 'package:frusan_precios/src/models/form_precio_view.dart';
import 'package:frusan_precios/src/pages/home/home_page.dart';
import 'package:frusan_precios/src/shared/constants_shared.dart';
import 'package:frusan_precios/src/shared/page_routes_shared.dart';



class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final propiedadMenu = Provider.of<MenuView>(context);

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Color(0xFFFAFAFA)),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/frusan/drawer.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              selected: false,
              leading: Icon(Icons.home, color: Theme.of(context).primaryColor),
              title: Text(
                'Inicio',
                style: textStyleMenuDrawer(context),
              ),
              onTap: () {
                //propiedadMenu.menuSelected = 'inicio';

                Navigator.of(context).pushReplacement(PageRoutes.sharedAxis(
                    () => HomePage(), SharedAxisTransitionType.scaled, .5));
              },
            ),               
            Visibility(
              visible: true,
              child: ListTile(
                selected: false,
                leading: Icon(Icons.attach_money,
                    color: Theme.of(context).primaryColor),
                title: Text(
                  'Completar Precios',
                  style: textStyleMenuDrawer(context),
                ),
                onTap: () {
                  //propiedadMenu.menuSelected = 'ctacteAnticipos';

                  Navigator.of(context).pushReplacement(PageRoutes.sharedAxis(
                      () => MultiProvider(providers: [                            
                            Provider(create: (_) => FormPrecioView()),                           
                            Provider(create: (_) => RecibidorService()),
                            Provider(create: (_) => NaveService())                            
                          ], child: PrecioFormPage()),
                      SharedAxisTransitionType.scaled,
                      .5));
                },
              ),
            ),      
            AboutListTile(
              icon: Icon(Icons.info_outline,
                  color: Theme.of(context).primaryColor),
              child: Text('Acerca de', style: textStyleMenuDrawer(context)),
              applicationIcon: Icon(Icons.settings_applications,
                  size: 65, color: Theme.of(context).primaryColor),
              applicationName: 'Frusan Precios App',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2021 Frusan S.A.',
              aboutBoxChildren: [
                ///Content goes here...
              ],
            )
          ],
        ),
      ),
    );
  }
}
