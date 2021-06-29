import 'dart:convert';
import 'package:coopstamariana/model/DerechoModel.dart';
import 'package:coopstamariana/model/usuario.dart';
import 'package:coopstamariana/screens/registroDerecho/registroDerecho.dart';
import 'package:coopstamariana/screens/registroLectura/registroLectura.dart';
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
  List<DerechoDeAgua> _derechosUser = [];
  final controller = TextEditingController();
//METHOD TO GET DERECHOS OF USER

  Future<Null> _getDerechos() async {
    final response = await http.get(Uri.parse(
      'http://localhost:8000/derecho/derechos?cedula=0106330145',
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
    Size size = MediaQuery.of(context).size;
    return new ListView.builder(
        itemCount: _usuarios.length,
        itemBuilder: (context, index) {
          return new Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            color: Colors.purple.shade100,
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
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
                    Icon(Icons.person, color: Colors.yellowAccent),
                    Text(_usuarios[index].id),
                    Text(_usuarios[index].direccion),
                    Text(_usuarios[index].correo),
                  ],
                ),
                trailing: SizedBox(
                  width: size.width * 0.5,
                  child: new ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    buttonPadding: EdgeInsets.all(8.0),
                    // this will take space as minimum as posible(to center)
                    children: <Widget>[
                      new FloatingActionButton.extended(
                        onPressed: () {
                          _derechosUser = [];
                          _getDerechos().then((value) {
                            return _buildResultDerechos();
                          });
                        },
                        label: Text("Lectura"),
                        icon: Icon(Icons.add),
                      ),
                      new FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegistroDerecho(_usuarios[index].id)),
                          );
                        },
                        label: Text("Derecho"),
                        icon: Icon(Icons.add_moderator),
                      ),
                      new FloatingActionButton.extended(
                        onPressed: () {},
                        label: Text("Datos"),
                        icon: Icon(Icons.edit_attributes),
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
                  Text(_usuarioSearch[i].correo),
                  FloatingActionButton.extended(
                    onPressed: () {
                      _getDerechos().then((value) => _buildResultDerechos);
                    },
                    label: Text("Lectura"),
                    icon: Icon(Icons.add),
                  )
                ],
              ),
              trailing: new ButtonBar(
                mainAxisSize: MainAxisSize
                    .min, // this will take space as minimum as posible(to center)
                children: <Widget>[
                  new FloatingActionButton.extended(
                    onPressed: () {
                      //Metod to get all Derechos of user
                      _derechosUser = [];
                      _getDerechos().then((value) {
                        return _buildResultDerechos;
                      });
                    },
                    label: Text("Lectura"),
                    icon: Icon(Icons.add),
                  ),
                  new FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text("Derecho"),
                    icon: Icon(Icons.add_moderator),
                  ),
                  new FloatingActionButton.extended(
                    onPressed: () {},
                    label: Text("Datos"),
                    icon: Icon(Icons.edit_attributes),
                  )
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

  _buildResultDerechos() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Seleccione su Derecho'),
            content: Container(
              width: double.minPositive,
              child: new ListView.builder(
                shrinkWrap: true,
                itemCount: _derechosUser.length,
                itemBuilder: (BuildContext context, int index) {
                  return new ListTile(
                    tileColor: Colors.amber,
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blueAccent,
                    ),
                    title: new Text(_derechosUser[index].numeroDeMedidor),
                    subtitle: new Text(_derechosUser[index].id),
                    trailing: new Column(
                      children: <Widget>[
                        new Text(_derechosUser[index].fechaAdquisicion)
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegistroLectura(_derechosUser[index].id)),
                      );
                    },
                  );
                },
              ),
            ),
          );
        });
  }
}
