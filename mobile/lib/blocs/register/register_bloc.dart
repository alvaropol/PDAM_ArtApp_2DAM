import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/dto/auth/register_dto.dart';
import 'package:flutter_application_art/models/response/auth/register_response.dart';
import 'package:flutter_application_art/repositories/auth/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegister);
  }

  void _doRegister(DoRegisterEvent event, Emitter<RegisterState> emit) async {
    final SharedPreferences prefs = await _prefs;
    emit(DoRegisterLoading());
    try {
      final RegisterDto registerDto = RegisterDto(
          username: event.username,
          password: event.password,
          verifyPassword: event.verifyPassword,
          email: event.email,
          nombre: event.nombre,
          pais: event.pais);
      final response = await authRepository.register(registerDto);
      prefs.setString('token', response.token!);
      prefs.setString('username', response.username!);
      prefs.setString('uuidUser', response.id!);
      emit(DoRegisterSuccess(response));
    } on Exception catch (e) {
      emit(DoRegisterError(e.toString()));
    }
  }
}
