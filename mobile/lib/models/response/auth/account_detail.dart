class AccountDetailResponse {
  String? uuid;
  String? nombre;
  String? username;
  String? createdAt;
  String? pais;
  List<Publicacion>? favoritos;

  AccountDetailResponse(
      {this.uuid,
      this.nombre,
      this.username,
      this.createdAt,
      this.pais,
      this.favoritos});

  AccountDetailResponse.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    nombre = json['nombre'];
    username = json['username'];
    createdAt = json['createdAt'];
    pais = json['pais'];
    if (json['favoritos'] != null) {
      favoritos = <Publicacion>[];
      json['favoritos'].forEach((v) {
        favoritos!.add(new Publicacion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['nombre'] = this.nombre;
    data['username'] = this.username;
    data['createdAt'] = this.createdAt;
    data['pais'] = this.pais;
    if (this.favoritos != null) {
      data['favoritos'] = this.favoritos!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Publicacion {
  String? uuid;
  String? titulo;
  String? image;
  int? cantidadValoraciones;
  double? valoracionMedia;

  Publicacion(
      {this.uuid,
      this.titulo,
      this.image,
      this.cantidadValoraciones,
      this.valoracionMedia});

  Publicacion.fromJson(Map<String, dynamic> json) {
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
