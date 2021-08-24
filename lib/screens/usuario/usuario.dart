import 'package:coopstamariana/components/profile/card_item.dart';
import 'package:coopstamariana/components/profile/stack_container.dart';
import 'package:flutter/material.dart';

class Usuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => CardItem(),
              shrinkWrap: true,
              itemCount: 1,
            )
          ],
        ),
      ),
    );
  }
}
