import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:mxl/Direccion/catalogo_hombres.dart' as pagos;
import 'package:mxl/Direccion/catalogo_postres.dart' as postres;
import 'package:mxl/Direccion/catalogo_mujeres.dart' as carpinteria;
import 'package:mxl/Direccion/catalogo_hogar.dart' as hogar;
import 'package:mxl/Direccion/catalogo_cipriana.dart' as cipriana;
import 'package:mxl/Modelo/cajas_modelo.dart';

import 'catalogo_mujeres.dart';

class gerencia_home extends StatefulWidget {
  @override
  gerencia_homeState createState() => gerencia_homeState();
}

class gerencia_homeState extends State<gerencia_home> with SingleTickerProviderStateMixin {

  late TabController controller;


  Future<void> pedidos (BuildContext context)async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final correoPersonal = user!.email;

    //QUITAR EL CORREO DEL ENCARGADO PARA QUE DIRECCION VEA TODAS LAS VENTAS Y NO SOLO LAS QUE TIENEN SU CORREO O ID UNICA
    //DES|PUES
    QuerySnapshot _myDoc2 = await FirebaseFirestore.instance.collection('Ventas').where('estado3', isEqualTo: 'nada').get();
    List<DocumentSnapshot> _myDocCount2 = _myDoc2.docs;
    print(""+_myDocCount2.length.toString());

    FirebaseFirestore.instance.collection('Notificaciones').doc("Direccion_Pedidos"+correoPersonal.toString()).set({'notificacion': _myDocCount2.length.toString()});
  }

  Widget pedidoNotificacion (BuildContext context){

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final correoPersonal = user!.email;

    return StreamBuilder(
      //En esta linea ingresar el nombre de la coecci
        stream: FirebaseFirestore.instance.collection('Notificaciones').doc("Direccion_Pedidos"+correoPersonal.toString()).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          //reference.where("title", isEqualTo: 'UID').snapshots(),

          else
          {
            Map<String, dynamic> userDocument = snapshot.data! as Map<String, dynamic>;
            return
              userDocument["notificacion"] == "0"?
              Tab(icon:Icon(Icons.scatter_plot), text: "PRODUCTOS",)
                  :
              Badge(
                position: BadgePosition(top: 30),
                badgeColor: Colors.white,
                badgeContent: Text(userDocument["notificacion"], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[900]),),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Tab(icon: Icon(Icons.scatter_plot), text: "PRODUCTOS",),
                ),
              );
          }
        }
    );
  }

  void uid ()async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final correoPersonal = user!.email;
    final uid = user.uid;
    print("uid home "+uid);

    FirebaseFirestore.instance.collection('Direccion_Registro').doc(correoPersonal.toString()).update({'uid': uid});

  }

  void t(){
    Future.delayed(Duration(seconds: 5), () {
      print(" This line is execute after 5 seconds");
    });
  }

  @override
  void initState() {
    t();
    //uid();
    // TODO: implement initState
    controller = TabController(length: 3, vsync: this);
    pedidos(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }


  FirebaseAuth auth = FirebaseAuth.instance;
  signOut() async {
    await auth.signOut();
  }

  Widget empresaNombre (BuildContext context){

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final correoPersonal = user!.email;

    return StreamBuilder<DocumentSnapshot<Object?>>(
      //En esta linea ingresar el nombre de la coecci
        stream: FirebaseFirestore.instance.collection('Socios_Registro').doc(correoPersonal.toString()).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          //reference.where("title", isEqualTo: 'UID').snapshots(),

          else
          {
            Map<String, dynamic> userDocument = snapshot.data!.data() as Map<String, dynamic>;
            String empresa = userDocument["empresa"];

            return Text("Bienvenido a "+empresa);

          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[800],
        title: Text("Bajafood"),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Column(
              children:  [
                Tab(icon: Icon(Icons.restaurant, color: Colors.white,)),
                Text("Alimentos", style: TextStyle(color: Colors.white),),
              ],
            ),
            Column(
              children:  [
                Tab(icon: Icon(Icons.local_drink, color: Colors.white,)),
                Text("Bebidas", style: TextStyle(color: Colors.white),),
              ],
            ),
            Column(
              children:  [
                Tab(icon: Icon(Icons.cake, color: Colors.white,)),
                Text("Postre", style: TextStyle(color: Colors.white),),
              ],
            ),
            //pedidoNotificacion(context),
            //Tab(icon: Icon(Icons.shopping_basket_outlined), text: "KIDS",),
            //Tab(icon: Icon(Icons.check_circle), text: "CHAT",),
            //total(context),
            //Tab(icon: Icon(Icons.scatter_plot), text: "OPCIONES",),
            //Tab(icon: Icon(Icons.attach_money), text: "VENTAS",),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          carpinteria.catalogo_mujeres(0,cajas_modelo("","","",0,0,0,0,0,"","","","","",0)),
          pagos.catalogo_hombres(0,cajas_modelo("","","",0,0,0,0,0,"","","","","",0)),
          postres.catalogo_postres(0,cajas_modelo("","","",0,0,0,0,0,"","","","","",0)),
          //historial.Categories_Screen2(),
          //chat.Chat_Interno(),
          //empleados.Empleados(),
        ],
      ),
    );
  }
}