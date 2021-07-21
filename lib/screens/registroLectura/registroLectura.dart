import 'dart:convert';

import 'package:coopstamariana/components/text_field_container.dart';
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

  register() async {
    final response =
        await http.post(Uri.parse('http://localhost:8000/lectura/create'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, Object>{
              "fecha": "12/12/2012",
              "lecturaAnterior": 0.0,
              "lecturaActual": double.parse(myControllerLectActual.text),
              "consumo": 0.0,
              "exceso": 0.0,
              "derechoAgua": widget.idDerecho
            }));
    if (response.statusCode == 200) {
      print("USUARIO CREADO");
    } else {
      throw Exception("CONECCTION LOSS");
    }
  }

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
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.date_range,
                      color: kPrimaryColor,
                    ),
                    border: InputBorder.none,
                    hintText: widget.now.toString())),
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
              register();
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
