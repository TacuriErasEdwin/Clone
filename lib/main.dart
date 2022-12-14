import 'package:flutter/material.dart';
import 'splash.dart';
import 'package:flutterapp3/screens/readjson.dart';
import 'package:flutterapp3/db/mongodb.dart';
import 'package:flutterapp3/screens/productosmongo.dart';


void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await MongoDB.conectar();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Splash(),
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      routes: <String, WidgetBuilder>{
        "/productosmongodb" : (BuildContext context) => ProductosMongo(),
        "/productosjson" : (BuildContext context) => ReadJson(),
        "/inicio" : (BuildContext context) => MyHomePage(title: 'Flutter',)
      },

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //Botones
    final button1 = new ElevatedButton(
      child: Text("Productos Json"),
      style: ElevatedButton.styleFrom(
          primary: Colors.deepOrange,
          onPrimary: Colors.white,
          elevation: 5,
          shadowColor: Colors.black
      ),
      onPressed: (){
        Navigator.pushNamed(context, "/productosjson");
        print("Ir al home");
      },
      onLongPress: (){
        print("Long hello raiced button");
      },
    );
    final button2 = IconButton(
      icon: Icon(
        Icons.adb,
        size: 20,
        color: Colors.red,
      ),
      tooltip:'Presioname',
      onPressed: (){
        Navigator.pushNamed(context, "/productos");
      },
    );

    final button3 = ElevatedButton.icon(
      icon: Icon(
        Icons.favorite,
        color: Colors.white,
        size: 20.0,
      ),
      label: Text('Boton con iconos'),
      onPressed: () {
        Navigator.pushNamed(context, "second");
      },
      style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
      ),
    );
    final button4 = ElevatedButton.icon(
      icon: Icon(
        Icons.favorite,
        color: Colors.white,
        size: 20.0,
      ),
      label: Text('Productos Mongo'),
      onPressed: () {
        Navigator.pushNamed(context, "/productosmongodb");
      },
      style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(20.0),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla principal'),
      ),
        body: Center(
          child:Container(
            child: Column(
              children: <Widget>[
                Text('Botonera'),
                button1,
                button2,
                button3,
                button4
              ],
            ),
          ),
        )
    );
  }


}