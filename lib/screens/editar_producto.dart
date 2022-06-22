import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:flutterapp3/db/mongodb.dart';
import 'package:flutterapp3/models/producto.dart';

class EditarProducto extends StatefulWidget{
  @override
  _EditarProductoState createState() => _EditarProductoState();
}

class _EditarProductoState extends State<EditarProducto>{
  static const EDICION =1;
  static const INSERCION =2;
  TextEditingController nombreController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  TextEditingController precioController = TextEditingController();

  @override
  Widget build(BuildContext context){
    var textoWidget ="Agregar producto";
    int operacion = INSERCION;
    Producto? producto;

    if(ModalRoute.of(context)?.settings.arguments != null){
      operacion= EDICION;
      producto = ModalRoute.of(context)?.settings.arguments as Producto;
      nombreController.text= producto.nombre;
      categoriaController.text= producto.categoria;
      precioController.text= producto.precio.toString();
      textoWidget="Editar producto";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(textoWidget),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nombreController,
                    decoration: InputDecoration(labelText: "Nombre"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: categoriaController,
                    decoration: InputDecoration(labelText: "Categoria"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: precioController,
                    decoration: InputDecoration(labelText: "Precio"),
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16,0,16,4),
              child: ElevatedButton(
                child: Text(textoWidget),
                onPressed: () {
                  if(operacion== EDICION){
                    _actualizarProducto(producto!);
                  }else{
                    _insertarProducto();
                  }
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _insertarProducto() async{
    final producto = Producto(
        id: M.ObjectId(),
        nombre: nombreController.text,
        precio: int.parse(precioController.text),
        categoria: categoriaController.text
    );
    await MongoDB.insertar(producto);
  }

  _actualizarProducto(Producto producto) async{
    final j = Producto(
        id: producto.id,
        nombre: nombreController.text,
        precio: int.parse(precioController.text),
        categoria: categoriaController.text
    );
    await MongoDB.actualizar(j);
  }

  @override
  void dispose(){
    super.dispose();
    nombreController.dispose();
    categoriaController.dispose();
    precioController.dispose();
  }
}