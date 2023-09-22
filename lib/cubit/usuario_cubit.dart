import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost_tracker_og/models/usuario_model.dart';
import 'package:ost_tracker_og/service/auth.dart';

part 'usuario_states.dart';

class UsuarioCubit extends Cubit<UsuarioStates> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService auth = AuthService();

  UsuarioCubit() : super(UsuarioInitial()) {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        emit(UsuarioLogin(Usuario(id: user.uid)));
      } else {
        emit(UsuarioLogout());
      }
    });
  }

  Future<void> login() async {
    Usuario? usuario;
    try {
      usuario = await auth.signIn();
      usuario == null ? emit(UsuarioLogout()) : emit(UsuarioLogout());
    } catch (e) {
      emit(UsuarioError(e.toString()));
    }
  }

  void logout() async {
    try {
      await _auth.signOut();
      emit(UsuarioLogout());
    } catch (e) {
      emit(UsuarioError(e.toString()));
    }
  }
}
