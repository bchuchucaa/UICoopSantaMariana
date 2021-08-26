import 'dart:convert';
import 'package:coopstamariana/model/lectura.dart';
import 'package:coopstamariana/model/usuario.dart';
import 'package:coopstamariana/screens/pago/PagoProceso.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class Pago extends StatefulWidget {
  @override
  _PagoState createState() => _PagoState();
}

class _PagoState extends State<Pago> {
  List<Usuario> _usuarios = [];
  List<Usuario> _usuarioSearch = [];
  List<Lectura> _lecturasUser = [];
  final controller = TextEditingController();
//METHOD TO GET DERECHOS OF USER

  Future<Null> _getLecturasByUser(cedula) async {
    final response = await http
        .get(Uri.parse(
          'http://localhost:8000/lectura/usuario/?cedula=' + cedula,
        ))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      print(response.body);
      setState(() {
        for (var item in jsonData) {
          _lecturasUser.add(Lectura(
            id: item["id"],
            fecha: item["fecha"],
            estado: item["estado"],
            lecturaActual: item["lecturaActual"],
            consumo: item["consumo"],
            exceso: item["exceso"],
            derechoAgua: item['derechoAgua'],
          ));
        }
      });
    } else {
      throw Exception("CONECCTION LOSS");
    }
  }

//METOD TO GET USER FROM API
  Future<Null> _getUsuarios() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/user/users'));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      print(body);
      setState(() {
        for (var item in jsonData) {
          _usuarios.add(
            Usuario(
                id: item["id"],
                nombre: item["nombre"],
                apellido: item["apellido"],
                direccion: item['direccion'],
                correo: item['correo'],
                rol: "NO INFO",
                password: "NO INFO"),
          );
        }
      });
    } else {
      throw Exception("CONECCTION LOSS");
    }
  }

  @override
  void initState() {
    super.initState();
    _getUsuarios();
  }

  Widget _buidUserslist() {
    Size size = MediaQuery.of(context).size;
    return new ListView.builder(
        itemCount: _usuarios.length,
        itemBuilder: (context, index) {
          return new Container(
            height: 160,
            width: size.width * 0.2,
            margin: new EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.primaries[index % Colors.primaries.length],
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(colors: [
                  Colors.primaries[index % Colors.primaries.length]
                      .withOpacity(0.3),
                  Colors.primaries[index % Colors.primaries.length],
                ])),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      _usuarios[index].nombre + " " + _usuarios[index].apellido,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            _lecturasUser = [];
                            _getLecturasByUser(_usuarios[index].id)
                                .then((value) {
                              return _buildResultLecturas();
                            });
                          },
                          icon: Icon(Icons.addchart_sharp),
                          tooltip: "Agregando Lectura",
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(_usuarios[index].correo,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(_usuarios[index].direccion,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(_usuarios[index].id,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ]),
            ),
          );
        });
  }

  Widget _buildSearchResults() {
    Size size = MediaQuery.of(context).size;

    return new ListView.builder(
        itemCount: _usuarioSearch.length,
        itemBuilder: (context, i) {
          return new Container(
            height: 160,
            width: size.width * 0.2,
            margin: new EdgeInsets.all(15),
            decoration: new BoxDecoration(
                color: Colors.primaries[i % Colors.primaries.length],
                borderRadius: BorderRadius.circular(20.0),
                gradient: LinearGradient(colors: [
                  Colors.primaries[i % Colors.primaries.length]
                      .withOpacity(0.3),
                  Colors.primaries[i % Colors.primaries.length],
                ])),
            child: new Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Text(
                      _usuarioSearch[i].nombre +
                          " " +
                          _usuarioSearch[i].apellido,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    new Row(
                      children: <Widget>[
                        new IconButton(
                          onPressed: () {
                            _lecturasUser = [];
                            _getLecturasByUser(_usuarioSearch[i].id)
                                .then((value) {
                              return _buildResultLecturas();
                            });
                          },
                          icon: Icon(Icons.library_books_sharp),
                          tooltip: "Ver lecturas",
                        ),
                      ],
                    ),
                    new Spacer(),
                    new Text(_usuarioSearch[i].correo,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    new Text(_usuarioSearch[i].direccion,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    new Text(_usuarioSearch[i].id,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ]),
            ),
          );
        });
  }

  Widget _buildSearchBox() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Busqueda', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
              onPressed: () {
                controller.clear();
                onSearchTextChanged('');
              },
              icon: new Icon(Icons.cancel)),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Container(
          color: kPrimaryColor,
          child: _buildSearchBox(),
        ),
        new Expanded(
            child: _usuarioSearch.length != 0 || controller.text.isNotEmpty
                ? _buildSearchResults()
                : _buidUserslist()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff212239),
      body: _buildBody(),
      resizeToAvoidBottomInset: true,
    );
  }

  onSearchTextChanged(String text) async {
    _usuarioSearch.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _usuarios.forEach((usuario) {
      if (usuario.id.contains(text) ||
          usuario.nombre.contains(text.toUpperCase()) ||
          usuario.apellido.contains(text.toUpperCase()))
        _usuarioSearch.add(usuario);
    });
    setState(() {});
  }

  _buildResultLecturas() {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Seleccione su Lectura'),
            content: Container(
              width: size.width,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    sortColumnIndex: 0,
                    columnSpacing: 20.0,
                    showCheckboxColumn: false,
                    columns: [
                      DataColumn(label: Text("FF")),
                      DataColumn(label: Text("CNSM")),
                      DataColumn(label: Text("EXC")),
                      DataColumn(label: Text("ACC"))
                    ],
                    rows: _lecturasUser
                        .map((lectura) => DataRow(
                                onSelectChanged: (b) {
                                  print(lectura.consumo);
                                },
                                cells: [
                                  DataCell(
                                    Container(
                                      width: size.width * 0.1,
                                      child: Text(lectura.fecha),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: size.width * 0.1,
                                      child: Text(lectura.consumo.toString()),
                                    ),
                                  ),
                                  DataCell(
                                    Text(lectura.exceso.toString()),
                                  ),
                                  DataCell(
                                    Container(
                                      width: size.width * 0.1,
                                      child: new FloatingActionButton(
                                        child: Icon(Icons.payment),
                                        hoverColor: Colors.green.shade400,
                                        focusColor: Colors.green.shade400,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PagoProcess(lectura.id
                                                          .toString())));
                                        },
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ]))
                        .toList(),
                  )),
            ),
          );
        });
  }
}
