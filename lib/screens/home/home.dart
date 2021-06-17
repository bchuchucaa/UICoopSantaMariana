import 'package:coopstamariana/screens/Welcome/components/background.dart';
import 'package:coopstamariana/screens/registro/registro.dart';
import 'package:coopstamariana/screens/verUsuarios/usuarios.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Background(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
              child: SizedBox(
                height: 350.0,
                width: 335.0,
                child: Text("TESTING ON SERVER"),
              )),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Registro()));
            },
            label: Text("REGISTRAR USUARIO"),
            icon: Icon(Icons.app_registration_outlined),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListUsuarios()));
            },
            label: Text("MODIFICAR USUARIO"),
            icon: Icon(Icons.edit),
          ),
        ],
      ),
    ));
  }
}
