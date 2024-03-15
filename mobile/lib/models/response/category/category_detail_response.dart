class CategoryDetailResponse {
  String? uuid;
  int? numero;
  String? nombre;
  String? image;
  List<Publicaciones>? publicaciones;

  CategoryDetailResponse(
      {this.uuid, this.numero, this.nombre, this.image, this.publicaciones});

  CategoryDetailResponse.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    numero = json['numero'];
    nombre = json['nombre'];
    image = json['image'];
    if (json['publicaciones'] != null) {
      publicaciones = <Publicaciones>[];
      json['publicaciones'].forEach((v) {
        publicaciones!.add(new Publicaciones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['numero'] = this.numero;
    data['nombre'] = this.nombre;
    data['image'] = this.image;
    if (this.publicaciones != null) {
      data['publicaciones'] =
          this.publicaciones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Publicaciones {
  String? uuid;
  String? titulo;
  String? image;
  int? cantidadValoraciones;
  double? valoracionMedia;

  Publicaciones(
      {this.uuid,
      this.titulo,
      this.image,
      this.cantidadValoraciones,
      this.valoracionMedia});

  Publicaciones.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    titulo = json['titulo'];
    image = json['image'];
    cantidadValoraciones = json['cantidadValoraciones'];
    valoracionMedia = json['valoracionMedia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['titulo'] = this.titulo;
    data['image'] = this.image;
    data['cantidadValoraciones'] = this.cantidadValoraciones;
    data['valoracionMedia'] = this.valoracionMedia;
    return data;
  }
}
