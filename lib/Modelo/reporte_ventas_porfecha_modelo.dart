
class reporte_ventas_porfecha_modelo{
  final String _id;
  String _fecha;
  String _correo;

  reporte_ventas_porfecha_modelo(this._id, this._fecha, this._correo);

  //Crea la estructura en la BD
  map(dynamic obj){
    _fecha = obj ['fecha'];
    _correo = obj ['correo'];

  }

  String get id => _id;
  String get fecha => _fecha;
  String get correo => _correo;

}