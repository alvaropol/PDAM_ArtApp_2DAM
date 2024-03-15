import 'package:flutter_application_art/models/dto/auth/login_dto.dart';
import 'package:flutter_application_art/models/dto/auth/register_dto.dart';
import 'package:flutter_application_art/models/response/auth/login_response.dart';
import 'package:flutter_application_art/models/response/auth/register_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
  Future<RegisterResponse> register(RegisterDto registerDto);
}
