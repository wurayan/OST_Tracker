part of 'usuario_cubit.dart';

abstract class UsuarioStates {}

class UsuarioInitial extends UsuarioStates {}

class UsuarioLogin extends UsuarioStates {
  final Usuario usuario;
  UsuarioLogin(this.usuario);
}

class UsuarioError extends UsuarioStates {
  final String error;
  UsuarioError(this.error);
}

class UsuarioLogout extends UsuarioStates {}
