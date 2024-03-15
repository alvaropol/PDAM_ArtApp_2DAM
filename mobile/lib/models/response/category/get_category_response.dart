class GetCategoryResponse {
  List<Category>? content;
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

  GetCategoryResponse(
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

  GetCategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Category>[];
      json['content'].forEach((v) {
        content!.add(new Category.fromJson(v));
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

class Category {
  String? uuid;
  int? numero;
  String? nombre;
  String? image;
  List<Publicaciones>? publicaciones;

  Category(
      {this.uuid, this.numero, this.nombre, this.image, this.publicaciones});

  Category.fromJson(Map<String, dynamic> json) {
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

class Pageable {
  int? pageNumber;
  int? pageSize;
  Sort? sort;
  int? offset;
  bool? unpaged;
  bool? paged;

  Pageable(
      {this.pageNumber,
      this.pageSize,
      this.sort,
      this.offset,
      this.unpaged,
      this.paged});

  Pageable.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    unpaged = json['unpaged'];
    paged = json['paged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['offset'] = this.offset;
    data['unpaged'] = this.unpaged;
    data['paged'] = this.paged;
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
