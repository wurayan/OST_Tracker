import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ost_tracker_og/models/usuario_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<Usuario?> get authStateChanged {
    Stream<Usuario?> res;
    try {
      res = _auth
          .authStateChanges()
          .map((User? user) => _usuarioFromFirebase(user));
    } catch (e) {
      throw Exception(e);
    }
    return res;
  }

  Usuario? _usuarioFromFirebase(User? user) {
    if (user == null) return null;
    Usuario usuario = Usuario(id: user.uid);
    return usuario;
  }

  Future<Usuario?> signIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User user = userCredential.user!;
        Usuario? usuario = _usuarioFromFirebase(user);
        return usuario;
      } on FirebaseAuthException catch (e) {
        throw Exception(e);
      } catch (e) {
        throw Exception();
      }
    } else {
      return null;
    }
  }
}
