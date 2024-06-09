import 'package:bloc/bloc.dart';
import 'package:flutter_application_art/models/dto/auth/login_dto.dart';
import 'package:flutter_application_art/models/response/auth/login_response.dart';
import 'package:flutter_application_art/repositories/auth/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<DoLoginEvent>(_doLogin);
  }

  void _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    final SharedPreferences prefs = await _prefs;

    emit(DoLoginLoading());
    try {
      final LoginDto loginDto =
          LoginDto(username: event.username, password: event.password);
      final response = await authRepository.login(loginDto);
      emit(DoLoginSuccess(response));
      prefs.setString('token', response.token!);
      prefs.setString('username', response.username!);
      prefs.setString('uuidUser', response.id!);
    } on Exception catch (e) {
      if (e.toString().contains('This user is banned')) {
        emit(DoLoginError('This user is banned'));
      } else {
        emit(DoLoginError(e.toString()));
      }
    }
  }
}
