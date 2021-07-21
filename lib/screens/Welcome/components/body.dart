import 'dart:convert';
import 'package:coopstamariana/components/rounded_password_file.dart';
import 'package:coopstamariana/components/text_field_container.dart';
import 'package:coopstamariana/constants.dart';
import 'package:coopstamariana/model/usuario.dart';
import 'package:coopstamariana/screens/Welcome/components/background.dart';
import 'package:coopstamariana/screens/navigator/body.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final myController = TextEditingController();

  Future<Usuario> login() async {
    print(myController.text);
    final response = await http.post(
      Uri.parse('https://172.16.0.130:8000/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'correo': myController.text, 'password': '12345'}),
    );
    if (response.statusCode == 200) {
      print(Usuario.fromJson(jsonDecode(response.body)));
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("CONECCTION LOSS");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; //this size provide us total height and width of our screen
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Bienvenido Coop. Sta Mariana",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Image.asset(
            "/images/Santa_Marianita.jpeg",
            width: size.width * 0.45,
            height: size.height * 0.35,
          ),
          TextFielContainter(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: "Tu correo"),
            ),
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Inicio()),
              );
              //login().then((value) => [
              //if (value.nombre.isNotEmpty)
              //{

              //}
              //]);
            },
            label: const Text("LOGIN"),
            icon: const Icon(Icons.login),
            backgroundColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
