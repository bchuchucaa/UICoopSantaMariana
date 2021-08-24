import 'dart:convert';

import 'package:coopstamariana/constants.dart';
import 'package:coopstamariana/screens/registro/registro.dart';
import 'package:coopstamariana/screens/verUsuarios/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Appointment> _meetings = [];

  Future<Null> _getWorks() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/trabajos/all'));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      var parts = [];
      setState(() {
        for (var item in jsonData) {
          parts = [];
          parts = item["fecha"].toString().split("/");
          DateTime startTime = DateTime(int.parse(parts[2]),
              int.parse(parts[1]), int.parse(parts[0]), 9, 0, 6);
          DateTime endTime = startTime.add(const Duration(hours: 7));
          _meetings.add(Appointment(
              startTime: startTime,
              endTime: endTime,
              subject: 'Cumpleanos',
              color: Colors.green));
        }
      });
    } else {
      throw Exception("CONECCTION LOSS");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "/images/Santa_Marianita.jpeg",
            width: size.width * 0.30,
            height: size.height * 0.45,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: size.height * 0.1),
            width: size.width * 0.5,
            height: size.height * 0.75,
            child: Card(
              color: Colors.blue.shade200,
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      alignment: Alignment.center,
                      child: SfCalendar(
                        view: CalendarView.month,
                        initialDisplayDate: DateTime.now(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Registro()));
                    },
                    label: Text("REGISTRAR USUARIO"),
                    backgroundColor: kPrimaryColor,
                    icon: Icon(Icons.app_registration_outlined),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListUsuarios()));
                    },
                    backgroundColor: kPrimaryColor,
                    label: Text("MODIFICAR USUARIO"),
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Object> source) {
    appointments = source;
  }
}
