import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost_tracker_og/models/artista_model.dart';
import 'package:ost_tracker_og/service/usuario.dart';

class ArtistaFirestore {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final UsuarioFirestore _user = UsuarioFirestore();

  Future<List<Artista>> getArtistas() async {
    List<Artista> artistas = [];
    var res = await _db
        .collection("/artistas")
        .get()
        .onError((error, stackTrace) => throw Exception(error));
    for (var artista in res.docs) {
      Map<String, dynamic> map = artista.data();
      map["id"] = artista.id;
      artistas.add(Artista.fromMap(map));
    }
    return artistas;
  }

  saveArtista(Artista artista) async {
    artista.dono = _auth.currentUser!.uid;
    await _db
        .collection("/artistas")
        .add(Artista.toMap(artista))
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) => _user.saveArtista(value.id));
  }

  editArtista(Artista artista) async {
    await _db
        .doc("/artistas/${artista.id}")
        .update(Artista.toMap(artista))
        .onError((error, stackTrace) => throw Exception(error));
  }

  deletArtista(String id) async {
    await _db
        .doc("/artistas/$id")
        .delete()
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) => _user.deleteArtista(id));
  }
}
