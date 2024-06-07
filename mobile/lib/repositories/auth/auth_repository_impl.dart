import 'dart:convert';

import 'package:flutter_application_art/models/dto/auth/login_dto.dart';
import 'package:flutter_application_art/models/dto/auth/register_dto.dart';
import 'package:flutter_application_art/models/response/auth/login_response.dart';
import 'package:flutter_application_art/models/response/auth/register_response.dart';
import 'package:flutter_application_art/repositories/auth/auth_repository.dart';
import 'package:http/http.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _httpClient = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:8080/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginDto.toJson()),
    );
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else if (response.statusCode == 403) {
      throw Exception('This user is banned');
    } else {
      throw Exception('Failed to do login');
    }
  }

  @override
  Future<RegisterResponse> register(RegisterDto registerDto) async {
    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:8080/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registerDto.toJson()),
    );
    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to do register');
    }
  }
}
