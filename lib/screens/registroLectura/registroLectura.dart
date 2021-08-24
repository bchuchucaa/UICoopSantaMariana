import 'dart:convert';

import 'package:coopstamariana/components/text_field_container.dart';
import 'package:coopstamariana/screens/verUsuarios/usuarios.dart';
import 'package:coopstamariana/services/usuarioService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class RegistroLectura extends StatefulWidget {
  final String idDerecho;
  DateTime now = new DateTime.now();
  RegistroLectura(this.idDerecho);

  @override
  _RegistroLecturaState createState() => _RegistroLecturaState();
}

class _RegistroLecturaState extends State<RegistroLectura> {
  final myControllerLectActual = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (Material(
      child: Column(
        children: <Widget>[
          Image.asset(
            "/images/formulario.jpeg",
            width: size.width * 0.45,
            height: size.height * 0.15,
          ),
          Text("REGISTRATE AQUI TU LECTURA"),
          TextFielContainter(
            child: TextField(
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.code,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: widget.idDerecho),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerLectActual,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.next_plan,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Lectura Actual"),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              registerLectura(myControllerLectActual.text, widget.idDerecho);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListUsuarios()));
            },
            label: Text("REGISTRAR"),
            icon: Icon(
              Icons.app_registration_rounded,
              color: kPrimaryColor,
            ),
          )
        ],
      ),
    ));
  }
}
