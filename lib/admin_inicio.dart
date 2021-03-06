import 'package:flutter/material.dart';
// ignore: camel_case_types
class Admin_Inicio extends StatelessWidget {
  const Admin_Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[800],
        title: Text('Baja Food', style: const TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset : false,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20.0,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height:170),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: SizedBox(
                      height: 200,
                      child: Image.asset('images/ancestral.jpg'),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 800,
                  height: 50,
                  child: SizedBox(
                    child: RaisedButton(
                      color: Colors.yellow[800],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      child: Text('RESTAURANTE', style: TextStyle(color: Colors.white, fontSize: 20.0),),
                      onPressed: () async {

                        //Navigator.of(context).pushNamed("/panel_de_control");
                        Navigator.of(context).pushNamed("/gerencia_login");

                      },
                    ),
                  ),
                ),
              ),

              //Padding(
                //padding: EdgeInsets.all(20.0),
                //child: SizedBox(
                //width: 800,
                //height: 50,
                //child: SizedBox(
                  //child: RaisedButton(
                    //color: Colors.yellow[800],
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                  //child: Text('REPARTIDOR', style: TextStyle(color: Colors.white, fontSize: 20.0),),
                    //       onPressed: () async {
                 //Navigator.of(context).pushNamed("/repartidor_login");
                   //     },
                  //),
                //),
              //),
              //),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 800,
                  height: 50,
                  child: SizedBox(
                    child: RaisedButton(
                      color: Colors.yellow[800],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                      child: Text('PANEL DE CONTROL', style: TextStyle(color: Colors.white, fontSize: 20.0),),
                      onPressed: () async {

                        //al entrar ver lista de afiliados, boton flotante par agregar nuevos afiliados.
                        //Navigator.of(context).pushNamed("/panel_de_control");
                        Navigator.of(context).pushNamed("/panel_login");

                      },
                    ),
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
