import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost_tracker_og/models/musica_model.dart';

class UsuarioFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> musicaToMap(Musica musica) => {
        "id": musica.id,
        "anotacoes": musica.anotacoes,
        "tags":
            musica.tags != null ? musica.tags!.map((e) => e.id).toList() : [],
        "generos": List.from(musica.generos.map((e) => e.id).toList())
      };

  Future<Map<String, dynamic>> getMusica(String id) async {
    var res = await _db
        .doc("/usuarios/${_auth.currentUser!.uid}/musicas/$id")
        .get()
        .onError((error, stackTrace) => throw Exception(error));
    return res.data() ?? {};
  }

  saveMusica(Musica musica) async {
    await _db
        .doc("/usuarios/${_auth.currentUser!.uid}/musicas/${musica.id}")
        .set(musicaToMap(musica))
        .onError((error, stackTrace) => throw Exception(error));
  }

  editMusica(Musica musica) async {
    await _db
        .doc("/usuarios/${_auth.currentUser!.uid}/musicas/${musica.id}")
        .update(musicaToMap(musica))
        .onError((error, stackTrace) => throw Exception(error));
  }

  deleteMusica(String id) async {
    await _db
        .doc("/usuarios/${_auth.currentUser!.uid}/musicas/$id")
        .delete()
        .onError((error, stackTrace) => throw Exception(error));
  }

  saveTag(String id) async {
    await _db.doc("/usuarios/${_auth.currentUser!.uid}").set({
      "tags": FieldValue.arrayUnion([id])
    }, SetOptions(merge: true)).onError(
        (error, stackTrace) => throw Exception(error));
  }

  deleteTag(String id) async {
    await _db.doc("/usuarios/${_auth.currentUser!.uid}").update({
      "tags": FieldValue.arrayRemove([id])
    }).onError((error, stackTrace) => throw Exception(error));
  }

  saveGenero(String id) async {
    await _db.doc("/usuarios/${_auth.currentUser!.uid}").set({
      "generos": FieldValue.arrayUnion([id])
    }, SetOptions(merge: true)).onError(
        (error, stackTrace) => throw Exception(error));
  }

  deleteGenero(String id) async {
    await _db.doc("/usuarios/${_auth.currentUser!.uid}").update({
      "generos": FieldValue.arrayRemove([id])
    }).onError((error, stackTrace) => throw Exception(error));
  }

  savePlaylist(String id) async {
    await _db.doc("/usuarios/${_auth.currentUser!.uid}").set({
      "playlists": FieldValue.arrayUnion([id])
    }, SetOptions(merge: true)).onError(
        (error, stackTrace) => throw Exception(error));
  }

  deletePlaylist(String id) async {
    await _db.doc("/usuarios/${_auth.currentUser!.uid}").update({
      "playlists": FieldValue.arrayRemove([id])
    }).onError((error, stackTrace) => throw Exception(error));
  }

  saveArtista(String id) async {
    await _db.doc("/usuarios/${_auth.currentUser!.uid}").set({
      "artistas": FieldValue.arrayUnion([id])
    }, SetOptions(merge: true)).onError(
        (error, stackTrace) => throw Exception(error));
  }

  deleteArtista(String id) async {
    await _db.doc("/usuarios/${_auth.currentUser!.uid}").update({
      "artistas": FieldValue.arrayRemove([id])
    }).onError((error, stackTrace) => throw Exception(error));
  }
}
