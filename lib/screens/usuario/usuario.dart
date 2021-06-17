import 'package:coopstamariana/components/rounded_input_field.dart';
import 'package:coopstamariana/components/text_field_container.dart';
import 'package:flutter/material.dart';

class Usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (Center(
        child: Container(
      width: size.width * 0.5,
      height: size.height * 0.4,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(29),
        ),
        color: Colors.yellow,
        child: Column(
          children: <Widget>[
            AppBar(title: Text("User data")),
            RoundedInputField(
              hintText: "Usuario",
              onChanged: (String value) {},
            ),
            RoundedInputField(
              hintText: "Direccion",
              onChanged: (String value) {},
            ),
          ],
        ),
      ),
    )));
  }
}
