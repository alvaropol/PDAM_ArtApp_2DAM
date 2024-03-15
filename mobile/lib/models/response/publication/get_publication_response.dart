class GetPublicationResponse {
  List<Publication>? content;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  GetPublicationResponse(
      {this.content,
      this.pageable,
      this.last,
      this.totalPages,
      this.totalElements,
      this.size,
      this.number,
      this.sort,
      this.first,
      this.numberOfElements,
      this.empty});

  GetPublicationResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Publication>[];
      json['content'].forEach((v) {
        content!.add(new Publication.fromJson(v));
      });
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['size'] = this.size;
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    data['empty'] = this.empty;
    return data;
  }
}

class Publication {
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

  Publication(
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

  Publication.fromJson(Map<String, dynamic> json) {
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

class Pageable {
  int? pageNumber;
  int? pageSize;
  Sort? sort;
  int? offset;
  bool? paged;
  bool? unpaged;

  Pageable(
      {this.pageNumber,
      this.pageSize,
      this.sort,
      this.offset,
      this.paged,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['offset'] = this.offset;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({this.empty, this.sorted, this.unsorted});

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empty'] = this.empty;
    data['sorted'] = this.sorted;
    data['unsorted'] = this.unsorted;
    return data;
  }
}
