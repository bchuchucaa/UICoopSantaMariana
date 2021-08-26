import 'dart:convert';
import 'package:coopstamariana/model/DerechoModel.dart';
import 'package:coopstamariana/model/usuario.dart';
import 'package:coopstamariana/screens/registroDerecho/registroDerecho.dart';
import 'package:coopstamariana/screens/registroLectura/registroLectura.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListUsuarios extends StatefulWidget {
  @override
  _ListUsuariosState createState() => _ListUsuariosState();
}

class _ListUsuariosState extends State<ListUsuarios> {
  List<Usuario> _usuarios = [];
  List<Usuario> _usuarioSearch = [];
  List<DerechoDeAgua> _derechosUser = [];
  final controller = TextEditingController();
//METHOD TO GET DERECHOS OF USER

  Future<Null> _getDerechos(usuario) async {
    final response = await http.get(Uri.parse(
      'http://localhost:8000/derecho/derechos?cedula=' + usuario,
    ));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      print(response.body);
      setState(() {
        for (var item in jsonData) {
          _derechosUser.add(DerechoDeAgua(
            id: item["id"].toString(),
            usuario: item["usuario_id"],
            fechaAdquisicion: item["fecha"],
            numeroDeMedidor: item["numero_medidor"],
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
          _usuarios.add(Usuario(
              id: item["id"],
              nombre: item["nombre"],
              apellido: item["apellido"],
              direccion: item['direccion'],
              correo: item['correo'],
              rol: "NO INFO",
              password: "NO TEXT"));
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
          return Container(
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
                            _derechosUser = [];
                            _getDerechos(_usuarios[index].id).then((value) {
                              return _buildResultDerechos();
                            });
                          },
                          icon: Icon(Icons.addchart_sharp),
                          tooltip: "Agregando Lectura",
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistroDerecho(_usuarios[index].id)),
                              );
                            },
                            icon: Icon(Icons.app_registration)),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person,
                          ),
                        )
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
                            _derechosUser = [];
                            _getDerechos(_usuarioSearch[i].id).then((value) {
                              return _buildResultDerechos();
                            });
                          },
                          icon: Icon(Icons.addchart_sharp),
                          tooltip: "Agregando Lectura",
                        ),
                        new IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistroDerecho(_usuarioSearch[i].id)),
                              );
                            },
                            icon: Icon(Icons.app_registration)),
                        new IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person,
                          ),
                        )
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
      appBar: new AppBar(
        title: new Text("REGISTRO DE INFORMACION"),
        elevation: 0.0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
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

  _buildResultDerechos() {
    Size size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Seleccione su Derecho'),
            content: Container(
              width: size.width * 0.6,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    sortColumnIndex: 0,
                    showCheckboxColumn: false,
                    columns: [
                      DataColumn(label: Text("Fecha")),
                      DataColumn(label: Text("Medidor")),
                      DataColumn(label: Text("Usuario")),
                      DataColumn(label: Text("Accion"))
                    ],
                    rows: _derechosUser
                        .map((derecho) => DataRow(
                                onSelectChanged: (b) {
                                  print(derecho.fechaAdquisicion);
                                },
                                cells: [
                                  DataCell(
                                    Text(derecho.fechaAdquisicion),
                                  ),
                                  DataCell(
                                    Text(derecho.numeroDeMedidor),
                                  ),
                                  DataCell(
                                    Text(derecho.usuario),
                                  ),
                                  DataCell(
                                    new TextButton(
                                        child: Text('Agregar'),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegistroLectura(derecho.id
                                                          .toString())));
                                        },
                                        style: TextButton.styleFrom(
                                            primary: Colors.red)),
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
