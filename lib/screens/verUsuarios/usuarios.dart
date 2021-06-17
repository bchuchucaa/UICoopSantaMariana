import 'dart:convert';
import 'dart:js';

import 'package:coopstamariana/components/text_field_container.dart';
import 'package:coopstamariana/model/usuario.dart';
import 'package:coopstamariana/screens/Welcome/components/background.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class ListUsuarios extends StatefulWidget {
  @override
  _ListUsuariosState createState() => _ListUsuariosState();
}

class _ListUsuariosState extends State<ListUsuarios> {
  List<Usuario> _usuarios = [];
  List<Usuario> _usuarioSearch = [];
  final controller = TextEditingController();

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
    // TODO: implement initState
    super.initState();
    _getUsuarios();
  }

  Widget _buidUserslist() {
    return new ListView.builder(
        itemCount: _usuarios.length,
        itemBuilder: (context, index) {
          return new Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            color: Colors.purple.shade100,
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24)),
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
                  Icon(Icons.person, color: Colors.yellowAccent),
                  Text(_usuarios[index].id),
                  Text(_usuarios[index].direccion),
                  Text(_usuarios[index].correo)
                ],
              ),
              trailing: FloatingActionButton.extended(
                onPressed: () {},
                label: Text("Editar"),
                icon: Icon(Icons.edit),
              ),
            ),
          );
        });
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
        itemCount: _usuarioSearch.length,
        itemBuilder: (context, i) {
          return new Card(
            color: Colors.blueGrey,
            child: new ListTile(
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
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
                  Icon(Icons.person, color: Colors.yellowAccent),
                  Text(_usuarioSearch[i].id),
                  Text(_usuarioSearch[i].direccion),
                  Text(_usuarioSearch[i].correo)
                ],
              ),
              trailing: FloatingActionButton.extended(
                onPressed: () {},
                label: Text("Editar"),
                icon: Icon(Icons.edit),
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
      appBar: new AppBar(
        title: new Text("USUARIOS REGISTRADOS"),
        elevation: 0.0,
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
}
