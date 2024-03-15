class RegisterDto {
  String? username;
  String? password;
  String? verifyPassword;
  String? email;
  String? nombre;
  String? pais;

  RegisterDto(
      {this.username,
      this.password,
      this.verifyPassword,
      this.email,
      this.nombre,
      this.pais});

  RegisterDto.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    verifyPassword = json['verifyPassword'];
    email = json['email'];
    nombre = json['nombre'];
    pais = json['pais'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['verifyPassword'] = this.verifyPassword;
    data['email'] = this.email;
    data['nombre'] = this.nombre;
    data['pais'] = this.pais;
    return data;
  }
}
