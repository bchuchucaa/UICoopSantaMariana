import 'package:coopstamariana/screens/Welcome/components/background.dart';
import 'package:coopstamariana/screens/registro/registro.dart';
import 'package:coopstamariana/screens/verUsuarios/usuarios.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "/images/Santa_Marianita.jpeg",
            width: size.width * 0.30,
            height: size.height * 0.45,
          ),
          Card(
            elevation: 10,
            child: Column(
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Registro()));
                  },
                  label: Text("REGISTRAR USUARIO"),
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
                  label: Text("MODIFICAR USUARIO"),
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
