import 'dart:convert';
import 'package:coopstamariana/components/text_field_container.dart';
import 'package:coopstamariana/model/Pago.dart';
import 'package:coopstamariana/screens/pago/pago.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import '../../constants.dart';

const PdfColor green = PdfColor.fromInt(0xffe06c6c); //darker background color
const PdfColor lightGreen =
    PdfColor.fromInt(0xffedabab); //light background color

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

  showSuccessToast() {
    Fluttertoast.showToast(
        msg: "Tu pago se a realizado correctamente.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 60,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showErrorToast() {
    Fluttertoast.showToast(
        msg: "Exporting your file failed. Nothing was downloaded.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 60,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<PagoModel> paymentVerification() async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/lectura/verification'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "id": '0',
        "atraso": '0',
        "otros": '0',
        "mensual": '2',
        "mora": '0',
        "total": '2',
        "lectura": widget.lectura
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return PagoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("CONECCTION LOSS");
    }
  }

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
      print("PAGADO");
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
          FutureBuilder<PagoModel>(
              future: paymentVerification(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      TextFielContainter(
                        child: TextField(
                          controller: myControllerAtraso,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.run_circle,
                                color: kPrimaryColor,
                              ),
                              border: InputBorder.none,
                              hintText: 'Atraso: ' +
                                  snapshot.data!.atraso.toString() +
                                  '\$'),
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
                              hintText: 'Otros: ' +
                                  snapshot.data!.otros.toString() +
                                  '\$'),
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
                              hintText: 'Mensual: ' +
                                  snapshot.data!.mensual.toString() +
                                  '\$'),
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
                                hintText: 'Mora: ' +
                                    snapshot.data!.mora.toString() +
                                    '\$')),
                      ),
                      TextFielContainter(
                        child: TextField(
                          controller: myControllerLectura,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.code,
                                color: kPrimaryColor,
                              ),
                              border: InputBorder.none,
                              hintText: 'Total: ' +
                                  snapshot.data!.total.toString() +
                                  '\$'),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return CircularProgressIndicator();
                }
              }),
          TextFielContainter(
            child: TextField(
              controller: myControllerLectura,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.code,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                  hintText: 'Lectura: ' + widget.lectura),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              paymentProcess();
              showSuccessToast();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pago()),
              );
            },
            label: Text("REGISTRAR"),
            icon: Icon(
              Icons.app_registration_rounded,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    ));
  }
}
