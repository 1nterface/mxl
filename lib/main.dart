//@dart=2.9
import 'package:mxl/Clientes/clientes_login.dart';
import 'package:mxl/Clientes/como_quieres_pagar.dart';
import 'package:mxl/Clientes/comprar_ahora.dart';
import 'package:mxl/Clientes/compras.dart';
import 'package:mxl/Clientes/compras_detalles.dart';
import 'package:mxl/Clientes/home.dart';
import 'package:mxl/Clientes/lista_restaurantes.dart';
import 'package:mxl/Clientes/menu_cliente.dart';
import 'package:mxl/Clientes/ofertas.dart';
import 'package:mxl/Clientes/registro.dart';
import 'package:mxl/Modelo/cajas_modelo2.dart';
import 'package:mxl/Panel/alta_socios.dart';
import 'package:mxl/Panel/home_panel.dart';
import 'package:mxl/Panel/lista_afiliados.dart';
import 'package:mxl/Panel/panel_de_control.dart';
import 'package:mxl/Panel/panel_de_control_detalle.dart';
import 'package:mxl/Panel/panel_login.dart';
import 'package:mxl/Panel/panel_registro.dart';
import 'package:mxl/Panel/soporte.dart';
import 'package:mxl/Panel/soporte_detalles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:mxl/admin_inicio.dart';
import 'package:mxl/Direccion/alta_costos_caja.dart';
import 'package:mxl/Direccion/alta_promociones.dart';
import 'package:mxl/Direccion/bottom_nav.dart';
import 'package:mxl/Direccion/direccion_registro_nuevo.dart';
import 'package:mxl/Direccion/gerencia_home.dart';
import 'package:mxl/Direccion/gerencia_login.dart';
import 'package:mxl/Direccion/historial.dart';
import 'package:mxl/Direccion/pedidos.dart';
import 'package:mxl/Direccion/reporte_ventas_direccion.dart';
import 'package:mxl/Modelo/cajas_modelo.dart';
import 'package:mxl/Modelo/nota_modelo.dart';
import 'package:mxl/olvidecontra.dart';
import 'Direccion/alta_portada.dart';
import 'Direccion/Chat_Interno.dart';
import 'Direccion/promociones_direccion.dart';
import 'Direccion/repartidores_direccion.dart';
import 'Modelo/panel_pedido_modelo.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize a new Firebase App instance
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {

        "/clientes_login": (BuildContext context) => clientes_login(),
        "/como_quieres_pagar": (BuildContext context) => como_quieres_pagar(nota_modelo("","",0,0,"", "", 0, "", 0, 0, "", "", "")),
        "/comprar_ahora": (BuildContext context) => comprar_ahora(nota_modelo("","",0,0,"", "", 0, "", 0, 0, "", "", "")),
        "/compras": (BuildContext context) => compras(),
        "/compras_detalles": (BuildContext context) => compras_detalle(panel_pedido_modelo("","","",0,0, 0, 0, 0, "", "", "", "", "", 0,"","",0,"","","")),
        "/home": (BuildContext context) => home(cajas_modelo("","","",0,0, 0, 0, 0, "", "", "", "", "", 0)),
        "/lista_restaurantes": (BuildContext context) => lista_restaurantes(),
        "/menu_cliente": (BuildContext context) => menu_cliente("","","","","", "", 0, 0, ""),
        "/ofertas": (BuildContext context) => ofertas(),
        "/registro": (BuildContext context) => registro(),

        '/olvide_contra': (BuildContext context) => olvidecontra(),
        "/gerencia_login": (BuildContext context) => gerencia_login(),
        "/gerencia_home": (BuildContext context) => gerencia_home(),
        "/alta_costos_caja": (BuildContext context) => alta_costos_caja(cajas_modelo("","","",0,0, 0, 0, 0, "", "", "", "", "", 0)),
        '/pedidos': (BuildContext context) => pedidos(),
        //'/catalogo_clientes': (BuildContext context) => Catalogo_Clientes(),
        '/alta_promociones': (BuildContext context) => alta_promociones(),
        '/promociones_direccion': (BuildContext context) => promociones_direccion(cajas_modelo("","","",0,0, 0, 0, 0, "", "", "", "", "", 0)),
        '/reporte_ventas_direccion': (BuildContext context) => reporte_ventas_direccion(),
        '/repartidores_direccion': (BuildContext context) => repartidores_direccion(),
        '/olvide_contra': (BuildContext context) => olvidecontra(),
        '/historial': (BuildContext context) => historial(),
        '/bottom_nav': (BuildContext context) => bottom_nav(),
        '/direccion_registro_nuevo': (BuildContext context) => direccion_registro_nuevo(),
        '/admin_inicio': (BuildContext context) => Admin_Inicio(),
        '/alta_promociones': (BuildContext context) => alta_promociones(),
        '/alta_portada': (BuildContext context) => alta_portada(),

        "/panel_login": (BuildContext context) => panel_login(),
        "/alta_socios": (BuildContext context) => alta_socios(),
        "/home_panel": (BuildContext context) => home_panel(),
        "/lista_afiliados": (BuildContext context) => lista_afiliados(),
        "/panel_de_control": (BuildContext context) => panel_de_control(),
        "/panel_de_control_detalles": (BuildContext context) => panel_de_control_detalle(panel_pedido_modelo("","","",0,0, 0, 0, 0, "", "", "", "", "", 0,"","",0,"","","")),
        "/panel_registro": (BuildContext context) => panel_registro(),
        "/soporte": (BuildContext context) => soporte(),
        "/soporte_detalles": (BuildContext context) => soporte_detalles(cajas_modelo2("","","",0,0, 0, 0, 0, "", "", "", "", "", 0,0,0,"")),


      },
      title: 'Socio Bajafood',
      theme: ThemeData(

      ),
      home:
      //Inicio(),
      clientes_login(),
      // <--- App Clientes


    );
  }
}