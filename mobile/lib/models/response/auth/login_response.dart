class LoginResponse {
  String? id;
  String? username;
  String? nombre;
  String? pais;
  String? role;
  String? token;

  LoginResponse(
      {this.id, this.username, this.nombre, this.pais, this.role, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nombre = json['nombre'];
    pais = json['pais'];
    role = json['role'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nombre'] = this.nombre;
    data['pais'] = this.pais;
    data['role'] = this.role;
    data['token'] = this.token;
    return data;
  }
}
