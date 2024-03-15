class RatingDTO {
  Publication? publication;
  User? user;
  int? rating;

  RatingDTO({this.publication, this.user, this.rating});

  RatingDTO.fromJson(Map<String, dynamic> json) {
    publication = json['publication'] != null
        ? new Publication.fromJson(json['publication'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.publication != null) {
      data['publication'] = this.publication!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['rating'] = this.rating;
    return data;
  }
}

class Publication {
  String? uuid;
  String? titulo;
  String? image;
  int? valoracionMedia;

  Publication({this.uuid, this.titulo, this.image, this.valoracionMedia});

  Publication.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    titulo = json['titulo'];
    image = json['image'];
    valoracionMedia = json['valoracionMedia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['titulo'] = this.titulo;
    data['image'] = this.image;
    data['valoracionMedia'] = this.valoracionMedia;
    return data;
  }
}

class User {
  String? uuid;
  String? nombre;
  String? username;

  User({this.uuid, this.nombre, this.username});

  User.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    nombre = json['nombre'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['nombre'] = this.nombre;
    data['username'] = this.username;
    return data;
  }
}
