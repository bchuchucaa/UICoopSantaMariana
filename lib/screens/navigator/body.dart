import 'dart:html';

import 'package:coopstamariana/screens/home/home.dart';
import 'package:coopstamariana/screens/pago/pago.dart';
import 'package:coopstamariana/screens/registro/registro.dart';
import 'package:coopstamariana/screens/usuario/usuario.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int paginaActual = 0;
  List<Widget> _paginas = [Home(), Pago(), Usuario(), Registro()];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //this size provide us total height and width of our screen
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bienvenido",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Cooperativa Santa Mariana"),
        ),
        body: _paginas[paginaActual],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              paginaActual = index;
            });
          },
          currentIndex: paginaActual,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Pagos"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "User")
          ],
        ),
      ),
    );
  }
}
