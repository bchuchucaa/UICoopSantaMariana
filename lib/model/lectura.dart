class Lectura {
  final int id;
  final String fecha;
  final String estado;
  final double lecturaActual;
  final double consumo;
  final double exceso;
  final int derechoAgua;

  Lectura(
      {required this.id,
      required this.fecha,
      required this.estado,
      required this.lecturaActual,
      required this.consumo,
      required this.exceso,
      required this.derechoAgua});
}
