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
          _usuarios.add(Usuario(
              id: item["id"],
              nombre: item["nombre"],
              apellido: item["apellido"],
              direccion: item['direccion'],
              correo: item['correo'],
              rol: "NO INFO"));
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
          return new Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            color: Colors.yellow.shade200,
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 6.0),
                  decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 1.0, color: Colors.white24)),
                  ),
                  child: Icon(Icons.info, color: Colors.blueAccent),
                ),
                title: new Text(
                  _usuarios[index].nombre + ' ' + _usuarios[index].apellido,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_usuarios[index].id),
                    Text(_usuarios[index].direccion),
                    Text(_usuarios[index].correo),
                  ],
                ),
                trailing: SizedBox(
                  width: size.width * 0.4,
                  child: new ButtonBar(
                    mainAxisSize: MainAxisSize.max,
                    // this will take space as minimum as posible(to center)
                    children: <Widget>[
                      new FloatingActionButton.extended(
                        onPressed: () {
                          _lecturasUser = [];
                          _getLecturasByUser(_usuarios[index].id).then((value) {
                            return _buildResultLecturas();
                          });
                        },
                        label: Text("Ver lecturas"),
                        icon: Icon(Icons.select_all),
                        backgroundColor: kPrimaryColor,
                        hoverColor: Colors.grey,
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
        itemCount: _usuarioSearch.length,
        itemBuilder: (context, i) {
          return new Card(
            color: Colors.green.shade100,
            child: new ListTile(
              leading: Container(
                padding: EdgeInsets.only(right: 6.0),
                decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24)),
                ),
                child: Icon(Icons.info, color: Colors.blueAccent),
              ),
              title: new Text(
                  _usuarioSearch[i].nombre + ' ' + _usuarioSearch[i].apellido),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_usuarioSearch[i].id),
                  Text(_usuarioSearch[i].direccion),
                  Text(_usuarioSearch[i].correo),
                ],
              ),
              trailing: new ButtonBar(
                mainAxisSize: MainAxisSize
                    .min, // this will take space as minimum as posible(to center)
                children: <Widget>[
                  new FloatingActionButton.extended(
                    onPressed: () {
                      _lecturasUser = [];
                      _getLecturasByUser(_usuarioSearch[i].id).then((value) {
                        return _buildResultLecturas();
                      });
                    },
                    label: Text("Ver lecturas"),
                    icon: Icon(Icons.select_all),
                  ),
                ],
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
              width: size.width * 0.6,
              child: new ListView.builder(
                shrinkWrap: true,
                itemCount: _lecturasUser.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                    child: ListTile(
                      tileColor: Colors.amber,
                      leading: Icon(
                        Icons.account_box,
                        color: Colors.blueAccent,
                      ),
                      title: new Text(_lecturasUser[index].fecha),
                      subtitle:
                          new Text(_lecturasUser[index].consumo.toString()),
                      trailing: new TextButton(
                          child: Text('Pagar'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PagoProcess(
                                        _lecturasUser[index].id.toString())));
                          },
                          style: TextButton.styleFrom(primary: Colors.red)),
                      onTap: () {},
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                  );
                },
              ),
            ),
          );
        });
  }
}
