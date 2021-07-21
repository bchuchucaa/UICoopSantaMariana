import 'package:coopstamariana/constants.dart';
import 'package:coopstamariana/screens/registro/registro.dart';
import 'package:coopstamariana/screens/verUsuarios/usuarios.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "/images/Santa_Marianita.jpeg",
            width: size.width * 0.30,
            height: size.height * 0.45,
          ),
          Container(
            width: size.width * 0.4,
            height: size.height * 0.5,
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
              color: Colors.yellowAccent,
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                    child: Text(
                      "PANEL DE CONTROL",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Registro()));
                    },
                    label: Text("REGISTRAR USUARIO"),
                    backgroundColor: kPrimaryColor,
                    icon: Icon(Icons.app_registration_outlined),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListUsuarios()));
                    },
                    backgroundColor: kPrimaryColor,
                    label: Text("MODIFICAR USUARIO"),
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
