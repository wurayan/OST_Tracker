import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost_tracker_og/models/artista_model.dart';
import 'package:ost_tracker_og/service/genero.dart';
import 'package:ost_tracker_og/service/usuario.dart';

class ArtistaFirestore {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final UsuarioFirestore _user = UsuarioFirestore();
  final GeneroFirestore _genero = GeneroFirestore();

  Future<List<Artista>> getArtistas() async {
    List<Artista> artistas = [];
    var res = await _db
        .collection("/artistas")
        .get()
        .onError((error, stackTrace) => throw Exception(error));
    for (var artista in res.docs) {
      Map<String, dynamic> map = artista.data();
      map["id"] = artista.id;
      map["generos"] = await Future.wait(List.from(map["generos"])
          .map((e) async => await _genero.getOnlyGenero(e))
          .toList());
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
    if (artista.dono != _auth.currentUser!.uid) return;
    await _db
        .doc("/artistas/${artista.id}")
        .update(Artista.toMap(artista))
        .onError((error, stackTrace) => throw Exception(error));
  }

  deleteArtista(Artista artista) async {
    if (artista.dono != _auth.currentUser!.uid) return;
    await _db
        .doc("/artistas/${artista.id}")
        .delete()
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) => _user.deleteArtista(artista.id));
  }
}
