import 'dart:convert';

import 'package:coopstamariana/components/text_field_container.dart';
import 'package:coopstamariana/model/usuario.dart';
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
  final myControllerId = TextEditingController();

  final myControllerNombre = TextEditingController();

  final myControllerApellido = TextEditingController();

  final myControllerDireccion = TextEditingController();

  final myControllerCorreo = TextEditingController();

  final myControllerPassword = TextEditingController();

  register(Usuario user) async {
    final response =
        await http.post(Uri.parse('http://localhost:8000/register/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'id': user.id,
              'nombre': user.nombre,
              'apellido': user.apellido,
              'direccion': user.direccion,
              'correo': user.correo,
              'password': myControllerPassword.text
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
              controller: myControllerId,
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
                controller: myControllerNombre,
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
              controller: myControllerDireccion,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.arrow_left,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Lectura Anterior"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerCorreo,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.next_plan,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Lectura Actual"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerPassword,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.money,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Consumo"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerPassword,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.alarm,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Exceso"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerPassword,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.password,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Subtotal"),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              Usuario user = new Usuario(
                  id: myControllerId.text,
                  nombre: myControllerNombre.text.toUpperCase(),
                  apellido: myControllerApellido.text.toUpperCase(),
                  direccion: myControllerDireccion.text.toUpperCase(),
                  correo: myControllerCorreo.text,
                  rol: "usuario");
              register(user);
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
