class PagoModel {
  final int id;
  final double atraso;
  final double otros;
  final double mensual;
  final double mora;
  final double total;
  final int lectura;

  PagoModel(
      {required this.id,
      required this.atraso,
      required this.otros,
      required this.mensual,
      required this.mora,
      required this.total,
      required this.lectura});

  factory PagoModel.fromJson(Map<String, dynamic> item) {
    return PagoModel(
        atraso: item["atraso"],
        lectura: item["lectura"],
        mensual: item["mensual"],
        mora: item["mora"],
        otros: item["otros"],
        total: item["total"],
        id: item["id"]);
  }
}
