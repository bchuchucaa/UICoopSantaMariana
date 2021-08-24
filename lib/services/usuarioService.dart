import 'dart:convert';
import 'package:coopstamariana/model/lectura.dart';

import 'notificationSevice.dart' as notification;
import 'package:coopstamariana/model/usuario.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

registerUser(Usuario user) async {
  try {
    final response = await http
        .post(Uri.parse(urlServ + '/register/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'id': user.id,
              'nombre': user.nombre,
              'apellido': user.apellido,
              'direccion': user.direccion,
              'correo': user.correo,
              'password': user.password
            }))
        .then((value) => notification.showSuccessToast("El usuario " +
            user.nombre +
            " " +
            user.apellido +
            " se registro correctamente .. :)"));
  } catch (err) {
    notification.showErrorToast(
        "No se pudo registrar el usuario .. :( " + err.toString());
  }
}

registerLectura(String lectura, String derecho) async {
  try {
    final response = await http
        .post(Uri.parse(urlServ + '/lectura/create'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, Object>{
              "id": 0,
              "fecha": "12/12/2012",
              "estado": "null",
              "lecturaActual": lectura,
              "consumo": 0.0,
              "exceso": 0.0,
              "derechoAgua": derecho
            }))
        .then((value) => notification.showSuccessToast(
            "Se ha registrado la lectura correctamente.. :)"));
    return response;
  } catch (err) {
    notification.showErrorToast(
        "No se pudo registrar el usuario .. :( " + err.toString());
  }
}
