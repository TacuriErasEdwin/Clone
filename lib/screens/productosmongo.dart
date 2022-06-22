import 'package:flutter/material.dart';
import 'package:flutterapp3/db/mongodb.dart';
import 'package:flutterapp3/screens/fichaproducto.dart';
import 'package:flutterapp3/models/producto.dart';
import 'package:flutterapp3/screens/editar_producto.dart';


class ProductosMongo extends StatefulWidget{
  @override
  _ProductosMongoState createState() => _ProductosMongoState();
}
class _ProductosMongoState extends State<ProductosMongo>{
  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: MongoDB.getProductos(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Container(
            color: Colors.white,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black,
            ),
          );
        }else if(snapshot.hasError){
          var err=snapshot.hasError;
          return Container(
            color: Colors.white,
            child: Center(
              child: Text('Lo sentimos hay error ',
              style: Theme.of(context).textTheme.headline6),
            ),
          );
        }
        else{
          return Scaffold(
            appBar: AppBar(
              title: Text('Productos de tecnología'),
            ),
            body: ListView.builder(
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FichaProducto(
                      producto: Producto.fromMap(snapshot.data[index]),
                      onTapDelete: () async{
                        _eliminarProducto(Producto.fromMap(snapshot.data[index]));
                      },
                      onTapEdit:() async {
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (BuildContext context){
                              return EditarProducto();
                            },
                          settings: RouteSettings(
                            arguments: Producto.fromMap(snapshot.data[index]),
                          )
                        )).then((value) => setState((){}));
                      }
                    ),
                  );
                },
            itemCount: snapshot.data.length,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return EditarProducto();
                })).then((value) => setState((){}));
              },
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }
  _eliminarProducto(Producto producto) async{
    await MongoDB.eliminar(producto);
    setState(() {

    });
  }
}