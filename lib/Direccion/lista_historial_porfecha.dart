
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mxl/Direccion/historial_detalle.dart';
import 'package:mxl/Modelo/cajas_modelo.dart';
import 'package:flutter/material.dart';
import 'package:mxl/Modelo/reporte_ventas_porfecha_modelo.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class lista_historial_porfecha extends StatefulWidget {

  reporte_ventas_porfecha_modelo product;
  lista_historial_porfecha(this.product);

  @override
  lista_historial_porfechaState createState() => lista_historial_porfechaState();
}

class lista_historial_porfechaState extends State<lista_historial_porfecha> {

  CollectionReference reflistaproduccion = FirebaseFirestore.instance.collection('Pedidos_Jimena');

  Future<void> pedidos (BuildContext context)async{

    QuerySnapshot _myDoc2 = await FirebaseFirestore.instance.collection('Ventas').where('estado3', isEqualTo: "encamino").get();
    List<DocumentSnapshot> _myDocCount2 = _myDoc2.docs;
    print("Esto quiero: "+_myDocCount2.length.toString());

    FirebaseFirestore.instance.collection('Notificaciones').doc("Direccion_Pedidos").set({'notificacion': _myDocCount2.length.toString()});
  }

  var category;
  //FOLIO, NOMBRE, CELULAR, COLONIA, CALLE, NUMERO
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _celular = TextEditingController();
  final TextEditingController _colonia = TextEditingController();
  final TextEditingController _calle = TextEditingController();
  final TextEditingController _numero = TextEditingController();

  void totalDiario1(){

    //countDocuments();
    double total = 0;
    int folio;

    FirebaseFirestore.instance.collection('Pedidos_Jimena').where("estadoc", isEqualTo: "Entregado").where('miembrodesde', isEqualTo: widget.product.fecha).snapshots().listen((data) async {
      for (var doc in data.docs)  {
        //doc.reference.delete();
        //CREO QUE LA CLAVE ES MANDAR ESTEEste: TOTAL A PEDIDOS_INICIO

        total = total + doc['totalNota'];
        //total = total + doc['totalProducto'];
        //folio = doc['folio'];

        //SharedPreferences paso #1
        final prefst = await SharedPreferences.getInstance();
        prefst.setDouble('totalProductoDiario', total);

        //IOSink sink = file.openWrite(mode: FileMode.writeOnlyAppend);

        //sink.add(utf8.encode(total.toString())); //Use newline as the delimiter
        //sink.writeln();
        //await sink.flush();
        //await sink.close();

      }
      //var now = new DateTime.now();
      final prefst = await SharedPreferences.getInstance();
      var totalreal = prefst.getDouble('totalProductoDiario') ?? "";
      double tot = totalreal.hashCode.toDouble();

      FirebaseFirestore.instance.collection('Reporte_Diario').doc(widget.product.fecha).set({
        'totalNota': tot
      });

    });
  }

  @override
  void initState() {
    totalDiario1();
    print('Fecha de hoy: ${now.year}-${now.month}-${now.day}');
    // TODO: implement initState
    pedidos(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _sheetCarrito(context) async {

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text('Alta de Pedidos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(50)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red,
                            blurRadius: 5
                        )
                      ]
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    controller: _nombre,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.star,
                        color: Colors.green[700],
                      ),
                      hintText: 'Nombre Cliente',
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(50)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green,
                            blurRadius: 5
                        )
                      ]
                  ),
                  child: TextField(
                    controller: _celular,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.star,
                        color: Colors.green[700],
                      ),
                      hintText: 'Celular',
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(50)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green,
                            blurRadius: 5
                        )
                      ]
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    controller: _colonia,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.star,
                        color: Colors.green[700],
                      ),
                      hintText: 'Colonia',
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(50)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green,
                            blurRadius: 5
                        )
                      ]
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    controller: _calle,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.star,
                        color: Colors.green[700],
                      ),
                      hintText: 'Calle',
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(50)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green,
                            blurRadius: 5
                        )
                      ]
                  ),
                  child: TextField(
                    controller: _numero,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.star,
                        color: Colors.green[700],
                      ),
                      hintText: 'Numero Exterior',
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:  OutlinedButton(
                      onPressed: () async {

                        QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Pedidos_Jimena').orderBy('folio').get();
                        List<DocumentSnapshot> _myDocCount = _myDoc.docs;

                        final collRef = FirebaseFirestore.instance.collection('Pedidos_Jimena');
                        DocumentReference docReference = collRef.doc();

                        var now = DateTime.now();

                        int celular = int.parse(_celular.text);
                        int numeroext = int.parse(_numero.text);

                        docReference.set({
                          'folio': _myDocCount.length+1,
                          'newid': docReference.id,
                          'id': "987",
                          'nombreProducto': _nombre.text,
                          'celular': celular,
                          'colonia': _colonia.text,
                          'calle': _calle.text,
                          'numeroext': numeroext,
                          'miembrodesde': '${now.year}-${now.month}-${now.day}',
                        });

                        Navigator.pop(context);
                      },
                      child: Text(
                        "Registrar pedido",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            //fontSize: 14,
                            color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(backgroundColor: Colors.blue[800]),
                    ),

                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          );
        }
    );
  }

  CollectionReference refpersonal = FirebaseFirestore.instance.collection('Personal_Registro');

  FirebaseAuth auth = FirebaseAuth.instance;

  void _ventanaFlotante(BuildContext context){
    TextEditingController _numeroMovil = TextEditingController();

    void inputData() async{

      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final correoPersonal = user!.email;

      //SALASH2 PARA FOR ANTIGUO
      FirebaseFirestore.instance.collection('Clave').where("correo", isEqualTo: correoPersonal).get().then((snapshot) async {
        for (DocumentSnapshot doc in snapshot.docs) {

          var clave = doc['clave'];

          print(clave);

          final FirebaseAuth auth = FirebaseAuth.instance;
          final User? user = auth.currentUser;
          final uid = user!.uid;

          var uri = 'sms:+ '+_numeroMovil.text+'?body='+"Ingresa estos datos en tu registro.\n"+"Clave Unica: "+clave+"\n"+"Correo Empresa: "+correoPersonal.toString();
          if (await canLaunch(uri))
          {
            await launch(uri);
          }
          else
          {
            final FirebaseAuth auth = FirebaseAuth.instance;
            final User? user = auth.currentUser;
            final uid = user!.uid;
            // iOS
            var uri = _numeroMovil.text+clave;
            if (await canLaunch(uri))
            {
              await launch(uri);
            }
            else
            {
              throw 'Could not launch $uri';
            }
          }

        } //METODO THANOS FOR EACH

      });

    }

    Alert(
        context: context,
        title: "ENVIÓ DE CÓDIGO DE SEGURIDAD",
        content: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              controller: _numeroMovil,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone_android),
                labelText: 'Ingresa el número móvil',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              inputData();
              Navigator.pop(context);
            },
            child: const Text(
              "Enviar código de seguridad",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  final TextEditingController _tel = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  signOut() async {
    await _auth.signOut();
  }

  var now = DateTime.now();

  final DateTime _dateTime = DateTime(2022);

  bool porfecha = false;

  Widget listaHistorial(){
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final correo = user!.email;
    return Expanded(
      child: StreamBuilder(
        //Asi encontraremos los negocios por ciudad y sin problemas con la BD
          stream: reflistaproduccion.where('estadoc', isEqualTo: "Entregado").where('miembrodesde', isEqualTo: widget.product.fecha).where('correoNegocio', isEqualTo: widget.product.correo).orderBy('folio', descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return const Text("Loading..");
            }
            //reference.where("title", isEqualTo: 'UID').snapshots(),

            else
            {
              //ESTE SI FUNCIONA, VOLVER A HACER TODO COM ESTE WIDGET
              return ListView(
                children: snapshot.data!.docs.map((documents) {

                  //LAS VARIABLES QUE DELCARO AQUI HACEN EL BAD STATE!!!!!!!

                  return InkWell(
                    onLongPress: (){


                    },
                    onTap: () async{

                      await Navigator.push(context, MaterialPageRoute(builder: (context) => historial_detalle(cajas_modelo("", documents["tiempodeespera"],documents["tel"],documents["folio"],2,6862028991, 0, 777, documents["concepto"], documents["estado"], documents["tiempodeespera"],"", documents["newid"], 0))),);

                      FirebaseFirestore.instance.collection('Pedidos_Jimena').doc(documents["newid"]).update({'visto': 'si'});

                    },
                    child: Card(
                      elevation: 1.0,
                      color:
                      documents["visto"] == "no"?
                      Colors.white
                          :
                      Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(documents["hora"],style: const TextStyle(color: Colors.grey)),
                                  //Text("ID"+folio.toString(), style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(documents["miembrodesde"],style: const TextStyle(color: Colors.grey)),
                                  //Text("ID"+folio.toString(), style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("# "+documents["folio"].toString(),style: TextStyle(color: Colors.blue[800])),
                                  //Text("ID"+folio.toString(), style: TextStyle(color: Colors.white)),
                                ],
                              ),
                              Column(
                                children: [
                                  //Text(documents["nombrecliente"], textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),),

                                  Text("\$"+documents["totalNota"].toString()+".00", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue[800]),),

                                ],
                              ),
                              Column(
                                children: [
                                  Text(documents["concepto"],
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: TextStyle(color:Colors.blue[800])),
                                ],
                              ),
                              //
                              // InkWell(
                              //onTap: (){

                              //  _tiempoRecorrido(context, estado3, pendiente, transitopendiente, encamino, ensitio, finalizo, hora);

                              //},
                              //child: Icon(Icons.timer)
                              //),

                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }

          }
      ),
    );
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
            return const Text("Loading");
          }
          //reference.where("title", isEqualTo: 'UID').snapshots(),

          else
          {
            Map<String, dynamic> userDocument = snapshot.data!.data() as Map<String, dynamic>;
            String empresa = userDocument["empresa"];

            return Text("Ventas "+empresa);

          }
        }
    );
  }

  Widget totalDiario (BuildContext context){

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final correoPersonal = user!.email;

    return StreamBuilder<DocumentSnapshot<Object?>>(
      //Reporte_Diario       //FECHA ACTUAL O DE CALENDARIO
        stream: FirebaseFirestore.instance.collection('Reporte_Diario').doc(widget.product.fecha).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Loading");
          }
          //reference.where("title", isEqualTo: 'UID').snapshots(),

          else
          {
            Map<String, dynamic> userDocument = snapshot.data!.data() as Map<String, dynamic>;
            int total = userDocument["totalNota"];

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("TOTAL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),),
                const SizedBox(width: 20),
                Text("\$"+total.toString()+".00", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),),
              ],
            );

          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(
                  MediaQuery.of(context).size.width, 50.0)),
        ),          backgroundColor: Colors.blue[800],
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text("Reporte de ventas diario", style: TextStyle(color: Colors.white)),
                Text(widget.product.fecha, style: const TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20.0,),
            Container(
              color: Colors.blue[200],
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    totalDiario(context),
                  ],
                ),
              ),
            ),
            //SizedBox(height:15),
            Card(
              elevation: 1.0,
              color:
              Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Hora",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          //Text("ID"+folio.toString(), style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: const [
                          Text("Fecha", textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Folio",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          //Text("ID"+folio.toString(), style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: const [
                          Text("Monto", textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                        ],
                      ),
                      Column(
                        children: const [

                          Text("Concepto", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      //
                      // InkWell(
                      //onTap: (){

                      //  _tiempoRecorrido(context, estado3, pendiente, transitopendiente, encamino, ensitio, finalizo, hora);

                      //},
                      //child: Icon(Icons.timer)
                      //),

                    ],
                  ),
                ],
              ),
            ),
            //Text('${now.year}-${now.month}-${now.day}', style: TextStyle(color: Colors.yellow[800]),),
            listaHistorial()

          ],
        ),
      ),
    );
  }
}