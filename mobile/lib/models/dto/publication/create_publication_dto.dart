class CreatePublicationDTO {
  String? titulo;
  String? descripcion;
  String? tamanyoDimensiones;
  String? direccionObra;
  String? nombreMuseo;
  String? lat;
  String? lon;
  String? image;
  int? numeroCategoria;

  CreatePublicationDTO(
      {this.titulo,
      this.descripcion,
      this.tamanyoDimensiones,
      this.direccionObra,
      this.nombreMuseo,
      this.lat,
      this.lon,
      this.image,
      this.numeroCategoria});

  CreatePublicationDTO.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    tamanyoDimensiones = json['tamanyoDimensiones'];
    direccionObra = json['direccionObra'];
    nombreMuseo = json['nombreMuseo'];
    lat = json['lat'];
    lon = json['lon'];
    image = json['image'];
    numeroCategoria = json['numeroCategoria'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['descripcion'] = this.descripcion;
    data['tamanyoDimensiones'] = this.tamanyoDimensiones;
    data['direccionObra'] = this.direccionObra;
    data['nombreMuseo'] = this.nombreMuseo;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['image'] = this.image;
    data['numeroCategoria'] = this.numeroCategoria;
    return data;
  }
}
