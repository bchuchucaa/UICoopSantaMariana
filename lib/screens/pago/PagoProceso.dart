import 'dart:convert';

import 'package:coopstamariana/components/text_field_container.dart';
import 'package:coopstamariana/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class PagoProcess extends StatefulWidget {
  final String lectura;

  PagoProcess(this.lectura);

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<PagoProcess> {
  final myControllerLectura = TextEditingController();

  final myControllerAtraso = TextEditingController();

  final myControllerMensual = TextEditingController();

  final myControllerMora = TextEditingController();

  final myControllerTotal = TextEditingController();

  paymentProcess() async {
    final response = await http.post(Uri.parse(urlServ + '/pago/ejecutar'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, Object>{
          "id": 0,
          "atraso": 0,
          "otros": 0,
          "mensual": 2,
          "mora": 0,
          "total": 2,
          "lectura": widget.lectura
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
    var myControllerOtros;
    return (Material(
      child: Column(
        children: <Widget>[
          Image.asset(
            "/images/formulario.jpeg",
            width: size.width * 0.45,
            height: size.height * 0.15,
          ),
          Text("Verificar Pago"),
          TextFielContainter(
            child: TextField(
              controller: myControllerLectura,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.code,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: widget.lectura),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerAtraso,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.run_circle,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Atraso"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerOtros,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.add,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Otros"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerMensual,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.add,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Mensual"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerMora,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.add,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Mora"),
            ),
          ),
          TextFielContainter(
            child: TextField(
              controller: myControllerTotal,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.summarize,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Total"),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              paymentProcess();
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
