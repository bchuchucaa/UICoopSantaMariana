import 'dart:convert';

import 'package:coopstamariana/model/DerechoModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pago extends StatefulWidget {
  late Future<List<DerechoDeAgua>> derechosDeAgua;
  @override
  _PagoState createState() => _PagoState();
}

class _PagoState extends State<Pago> {
  late Future<List<DerechoDeAgua>> _listDerechoAgua;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Gestor de pagos"),
        ),
        body: Text("PAGO"));
  }

  List<Widget> _listDerechosA(List<DerechoDeAgua> data) {
    List<Widget> derechos = [];
    for (var derecho in data) {
      derechos.add(
        Card(
          child: Column(
            children: [Expanded(child: Text(derecho.numeroDeMedidor))],
          ),
        ),
      );
    }
    return derechos;
  }
}
