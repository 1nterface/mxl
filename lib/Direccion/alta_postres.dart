import 'dart:io';
import 'dart:io' show File;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mxl/Modelo/cajas_modelo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class alta_postres extends StatefulWidget {

  cajas_modelo product;
  alta_postres(this.product);

  @override
  alta_postresState createState() => alta_postresState();
}

class alta_postresState extends State<alta_postres> {

  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _descripcion = TextEditingController();
  final TextEditingController _precio = TextEditingController();
  final TextEditingController _existencia = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Widget> itemPhotosWidgetList = <Widget>[];

  final ImagePicker _picker = ImagePicker();
  File? file;
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];
  List<String> downloadUrl = <String>[];
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    double _screenwidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 480) {
            return displayPhoneUploadFormScreen(_screenwidth, _screenheight);
          } else {
            return displayWebUploadFormScreen(_screenwidth, _screenheight);
          }
        });
  }

  displayPhoneUploadFormScreen(_screenwidth, _screenheight) {
    return Container();
  }
  displayWebUploadFormScreen(_screenwidth, _screenheight) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(
                  MediaQuery.of(context).size.width, 50.0)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff552e5),
        title: Text("Alta Postres"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 100.0,
            ),
            Center(
              child: itemPhotosWidgetList.isEmpty
                  ? Center(
                child: MaterialButton(
                  onPressed: pickPhotoFromGallery,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Center(
                      child: Image.network(
                        "https://static.thenounproject.com/png/3322766-200.png",
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                  ),
                ),
              )
                  :
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 500,
                        height: 500,
                        child: Column(
                          children: itemPhotosWidgetList,
                        ),
                      ),
                      //SizedBox(height: 20.0,),
                      const SizedBox(height: 10.0,),

                      Expanded(
                        child: Column(children:[
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xfff552e5),
                                        blurRadius: 5
                                    )
                                  ]
                              ),
                              child: TextFormField(
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Escribe el correo';
                                  }
                                  return null;
                                },
                                controller: _nombre,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.arrow_forward_outlined,
                                    color: Color(0xfff552e5),
                                  ),
                                  hintText: 'Nombre',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50)
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xfff552e5),
                                        blurRadius: 5
                                    )
                                  ]
                              ),
                              child: TextFormField(
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Escribe el correo';
                                  }
                                  return null;
                                },
                                controller: _descripcion,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.announcement,
                                    color: Color(0xfff552e5),
                                  ),
                                  hintText: 'Descripcion',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50)
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xfff552e5),
                                        blurRadius: 5
                                    )
                                  ]
                              ),
                              child: TextFormField(
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Ingresa el precio';
                                  }
                                  return null;
                                },
                                controller: _precio,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.monetization_on_outlined,
                                    color: Color(0xfff552e5),
                                  ),
                                  hintText: 'Precio',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50)
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xfff552e5),
                                        blurRadius: 5
                                    )
                                  ]
                              ),
                              child: TextFormField(
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Ingresa la existencia';
                                  }
                                  return null;
                                },
                                controller: _existencia,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.monetization_on_outlined,
                                    color: Color(0xfff552e5),
                                  ),
                                  hintText: 'Existencia',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30.0,),
                        ]),
                      ),


                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 35.0,
                    left: 100.0,
                    right: 100.0,
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    color: Color(0xfff552e5),
                    onPressed: uploading ? null : () => upload(),
                    child: uploading
                        ? const SizedBox(
                      child: CircularProgressIndicator(),
                      height: 15.0,
                    )
                        : const Text(
                      "Subir imagen",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 30),
          ],
        ),
      ),
    );
  }

  addImage() {
    for (var bytes in photo!) {
      itemPhotosWidgetList.add(Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 400.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              child: kIsWeb
                  ? Image.network(File(bytes.path).path)
                  : Image.file(
                File(bytes.path),
              ),
            ),
          ),
        ),
      ));
    }
  }
  pickPhotoFromGallery() async {
    photo = await _picker.pickMultiImage();
    if (photo != null) {
      setState(() {
        itemImagesList = itemImagesList + photo!;
        addImage();
        photo!.clear();
      });
    }
  }
  upload() async {


    double lat = 0, lon = 0;

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final correoPersonal = user!.email;

    FirebaseFirestore.instance.collection('Socios_Registro').where("correo", isEqualTo: correoPersonal).get().then((snapshot) async {
      for (DocumentSnapshot doc in snapshot.docs) {

        var empresa = doc['empresa'];
        var ciudad = doc['ciudad'];
        lat = doc['latitud'];
        lon = doc['longitud'];

        print(empresa);
        print(lat);
        print(lon);

        //SharedPreferences paso #1
        final prefst = await SharedPreferences.getInstance();
        prefst.setString('empresa', empresa);
        prefst.setString('ciudad', ciudad);
        prefst.setDouble('lat', lat);
        prefst.setDouble('lon', lon);




      } //METODO THANOS FOR EACH

    });
    String productId = await uplaodImageAndSaveItemInfo();
    setState(() {
      uploading = false;
    });
  }
  Future<String> uplaodImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    PickedFile? pickedFile;
    //String? productId = const Uuid().v4();
    for (int i = 0; i < itemImagesList.length; i++) {
      file = File(itemImagesList[i].path);
      pickedFile = PickedFile(file!.path);

      await uploadImageToStorage(pickedFile, "hola");
    }
    return "hola";
  }
  uploadImageToStorage(PickedFile? pickedFile, String productId) async {
    //String? pId = const Uuid().v4();
    final collRef2 = FirebaseFirestore.instance.collection('Cajas');
    DocumentReference docReference2 = collRef2.doc();
    Reference reference =
    FirebaseStorage.instance.ref().child(docReference2.id.toString());
    await reference.putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    String value = await reference.getDownloadURL();
    downloadUrl.add(value);


    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Cajas').orderBy(
        'folio').get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;

    final collRef = FirebaseFirestore.instance.collection('Cajas');
    DocumentReference docReference = collRef.doc();

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final correoPersonal = user!.email;

    var now = DateTime.now();

    double costo = double.parse(_precio.text);
    int existencia = int.parse(_existencia.text);

    String nombre = _nombre.text;

    final prefst = await SharedPreferences.getInstance();
    String empresa = prefst.getString('empresa') ?? "";
    String ciudad = prefst.getString('ciudad') ?? "";

    Object lat = prefst.getDouble('lat') ?? "";
    Object lon = prefst.getDouble('lon') ?? "";

    print(empresa);
    print("lati "+lat.toString());
    print("longi "+lon.toString());

    docReference.set({
      //'lat': lat,
      //'lon': lon,
      'ciudad': ciudad,
      'empresa': empresa,
      //'subcategoria': widget.subcategoria,
      'correoNegocio': correoPersonal,
      'categoria': "Postres",
      //'categoriap': category2,
      'like': 0,
      'folio': _myDocCount.length + 1,
      'costoProducto': costo,
      'newid': docReference.id,
      'descripcion': _descripcion.text,
      'costo': costo,
      'id': "978",
      'nombreProducto': nombre,
      'foto': value,
      'miembrodesde': DateFormat("yyyy-MM-dd").format(now),
      'existencia': existencia,
    });

    //AQUI VA CODIGO PARA GUARDAR DATOS Y URL A CLOUD FIRESTORE
    Navigator.of(context).pop();

    print("Done: $value");

  }
}