class PublicationDetailResponse {
  String? uuid;
  String? artista;
  String? titulo;
  String? descripcion;
  String? tamanyoDimensiones;
  String? direccionObra;
  String? nombreMuseo;
  String? lat;
  String? lon;
  double? valoracionMedia;
  String? image;
  String? categoria;
  int? cantidadValoraciones;
  List<Comentarios>? comentarios;

  PublicationDetailResponse(
      {this.uuid,
      this.artista,
      this.titulo,
      this.descripcion,
      this.tamanyoDimensiones,
      this.direccionObra,
      this.nombreMuseo,
      this.lat,
      this.lon,
      this.valoracionMedia,
      this.image,
      this.categoria,
      this.cantidadValoraciones,
      this.comentarios});

  PublicationDetailResponse.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    artista = json['artista'];
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    tamanyoDimensiones = json['tamanyoDimensiones'];
    direccionObra = json['direccionObra'];
    nombreMuseo = json['nombreMuseo'];
    lat = json['lat'];
    lon = json['lon'];
    valoracionMedia = json['valoracionMedia'];
    image = json['image'];
    categoria = json['categoria'];
    cantidadValoraciones = json['cantidadValoraciones'];
    if (json['comentarios'] != null) {
      comentarios = <Comentarios>[];
      json['comentarios'].forEach((v) {
        comentarios!.add(new Comentarios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['artista'] = this.artista;
    data['titulo'] = this.titulo;
    data['descripcion'] = this.descripcion;
    data['tamanyoDimensiones'] = this.tamanyoDimensiones;
    data['direccionObra'] = this.direccionObra;
    data['nombreMuseo'] = this.nombreMuseo;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['valoracionMedia'] = this.valoracionMedia;
    data['image'] = this.image;
    data['categoria'] = this.categoria;
    data['cantidadValoraciones'] = this.cantidadValoraciones;
    if (this.comentarios != null) {
      data['comentarios'] = this.comentarios!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comentarios {
  String? usuario;
  String? comment;

  Comentarios({this.usuario, this.comment});

  Comentarios.fromJson(Map<String, dynamic> json) {
    usuario = json['usuario'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usuario'] = this.usuario;
    data['comment'] = this.comment;
    return data;
  }
}
