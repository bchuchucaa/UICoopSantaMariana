import 'dart:convert';

import 'package:coopstamariana/components/text_field_container.dart';
import 'package:coopstamariana/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
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
    return (Material(
      child: Column(
        children: <Widget>[
          Text("Registro Usuario"),
          TextFielContainter(
            child: TextField(
              controller: myControllerId,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.perm_identity,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Cedula"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerNombre,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Nombre"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerApellido,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Apellido"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerDireccion,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.location_city,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Direccion"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerCorreo,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.email,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Correo"),
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
                  hintText: "Password"),
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
