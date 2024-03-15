class GetCategoriesForm {
  String? nombre;
  int? numero;

  GetCategoriesForm({this.nombre, this.numero});

  GetCategoriesForm.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    numero = json['numero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['numero'] = this.numero;
    return data;
  }
}
