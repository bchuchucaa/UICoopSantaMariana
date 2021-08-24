class Usuario {
  final String id;
  final String nombre;
  final String apellido;
  final String direccion;
  final String correo;
  final String rol;
  final String password;
  Usuario(
      {required this.id,
      required this.nombre,
      required this.apellido,
      required this.direccion,
      required this.correo,
      required this.rol,
      required this.password});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        direccion: json['direccion'],
        correo: json['correo'],
        rol: json['rol'],
        password: json['password']);
  }
}
