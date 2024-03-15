part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final String username;
  final String password;
  final String verifyPassword;
  final String email;
  final String nombre;
  final String pais;
  DoRegisterEvent(this.username, this.password, this.verifyPassword, this.email,
      this.nombre, this.pais);
}
