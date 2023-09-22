import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/models/playlist_model.dart';
import 'package:ost_tracker_og/service/usuario.dart';

class PlaylistFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UsuarioFirestore _user = UsuarioFirestore();

  Future<List<Playlist>> getPlaylists() async {
    List<Playlist> playlists = [];
    var res = await _db
        .collection("/playlists")
        .where(Filter.or(Filter("dono", isEqualTo: _auth.currentUser!.uid),
            Filter("publico", isEqualTo: true)))
        .get()
        .onError((error, stackTrace) => throw Exception(error));
    for (var playlist in res.docs) {
      Map<String, dynamic> map = playlist.data();
      map["id"] = playlist.id;
      playlists.add(Playlist.fromMap(map));
    }
    return playlists;
  }

  savePlaylist(Playlist playlist) async {
    playlist.dono = _auth.currentUser!.uid;
    await _db
        .collection("/playlists")
        .add(Playlist.toMap(playlist))
        .onError((error, stackTrace) => throw Exception())
        .then((value) => _user.savePlaylist(value.id));
  }

  editPlaylist(Playlist playlist) async {
    await _db
        .doc("/playlists/${playlist.id}")
        .update(Playlist.toMap(playlist))
        .onError((error, stackTrace) => throw Exception(error));
  }

  deletePlaylist(String id) async {
    await _db
        .doc("/playlists/$id")
        .delete()
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) => _user.deletePlaylist(id));
  }

  Future<void> addMusica(String playlist, Musica musica) async {
    await _db.doc("/playlists/$playlist").update({
      "idMusicas": FieldValue.arrayUnion([musica.id])
    }).onError((error, stackTrace) => throw Exception(error));
  }

  Future<void> removerMusica(String playlist, Musica musica) async {
    await _db.doc("/playlists/$playlist").update({
      "idMusicas": FieldValue.arrayRemove([musica.id])
    }).onError((error, stackTrace) => throw Exception(error));
  }
}
