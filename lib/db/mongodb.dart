
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutterapp3/models/producto.dart';
import 'package:flutterapp3/providers/constantes.dart';

class MongoDB{
  static var db, coleccionProductos;

  static conectar() async{
    db = await Db.create('mongodb+srv://rlramirez:<password>@cluster0.wyzbm.mongodb.net/?retryWrites=true&w=majority');
    await db.open();
    coleccionProductos = db.collection(COLECCION);
  }

  static Future<List<Map<String, dynamic>>> getProductos() async{
    try{
      final productos = await coleccionProductos.find.toList();
      return productos;
    }catch(e){
      print(e);
      return Future.value();
    }
  }

  static insertar(Producto producto)async{
    await coleccionProductos.insertAll([producto.toMap()]);
  }

  static actualizar(Producto producto) async{
    var j = await coleccionProductos.findOne({"_id":producto.id});
    j["nombre"]=producto.nombre;
    j["precio"]=producto.precio;
    j["categoria"]=producto.categoria;
    await coleccionProductos.save(j);
  }

  static eliminar(Producto producto) async{
    await coleccionProductos.remove(where.id(producto.id));
  }
}
