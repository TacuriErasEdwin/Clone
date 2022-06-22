import 'package:flutter/material.dart';
import 'package:flutterapp3/models/producto.dart';

class FichaProducto extends StatelessWidget{
  FichaProducto ({required this.producto, required this.onTapDelete, required this.onTapEdit});
  final Producto producto;
  final VoidCallback onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context){
    return Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Text('${producto.precio}', style: Theme.of(context).textTheme.headline6),
        title: Text(producto.nombre),
        subtitle: Text(producto.categoria),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Icon(Icons.edit),
              onTap: onTapEdit,
            ),
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: onTapDelete,
            )
          ],
        ),
      ),
    );
  }
}