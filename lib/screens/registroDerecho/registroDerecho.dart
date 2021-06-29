import 'dart:convert';

import 'package:coopstamariana/components/text_field_container.dart';
import 'package:coopstamariana/model/DerechoModel.dart';
import 'package:coopstamariana/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class RegistroDerecho extends StatefulWidget {
  final String cedula;

  RegistroDerecho(this.cedula);

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<RegistroDerecho> {
  @override
  final myControllerId = TextEditingController();

  final myControllerDate = TextEditingController();

  final myControllerMedidor = TextEditingController();

  registerDerecho(DerechoDeAgua derecho) async {
    final response =
        await http.post(Uri.parse('http://localhost:8000/derecho/create'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'fecha_adquisicion': derecho.fechaAdquisicion,
              'numero_medidor': derecho.numeroDeMedidor,
              'usuario_id': derecho.id
            }));
    if (response.statusCode == 200) {
      print("DERECHO CREADO");
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
          Text("REGISTRA TU DERECHO DE AGUA AQUI"),
          TextFielContainter(
            child: TextField(
              controller: myControllerId,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: widget.cedula),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerDate,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.date_range_rounded,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Fecha de adquisicion"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerMedidor,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.code,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Numero de medidor"),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              DerechoDeAgua derecho = new DerechoDeAgua(
                  id: widget.cedula,
                  usuario: widget.cedula,
                  fechaAdquisicion: myControllerDate.text,
                  numeroDeMedidor: myControllerMedidor.text);
              registerDerecho(derecho);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
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
