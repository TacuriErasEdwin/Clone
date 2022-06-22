import 'package:mongo_dart/mongo_dart.dart';

class Producto{
  final ObjectId id;
  final String nombre;
  final int precio;
  final String categoria;

  const Producto ({required this.id, required this.nombre, required this.precio, required this.categoria});

  Map<String, dynamic> toMap(){
    return{
      '_id':id,
      'nombre':nombre,
      'precio':precio,
      'categoria':categoria
    };
  }

  Producto.fromMap(Map<String, dynamic> map)
      :nombre = map['nombre'],
      id = map['_id'],
      precio = map['precio'],
      categoria = map['categoria'];
}
