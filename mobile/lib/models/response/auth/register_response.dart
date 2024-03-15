class RegisterResponse {
  String? id;
  String? username;
  String? email;
  String? nombre;
  String? pais;
  String? role;
  String? createdAt;
  String? token;

  RegisterResponse(
      {this.id,
      this.username,
      this.email,
      this.nombre,
      this.pais,
      this.role,
      this.createdAt,
      this.token});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    nombre = json['nombre'];
    pais = json['pais'];
    role = json['role'];
    createdAt = json['createdAt'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['nombre'] = this.nombre;
    data['pais'] = this.pais;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['token'] = this.token;
    return data;
  }
}
