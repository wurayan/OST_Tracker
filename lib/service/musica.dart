import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost_tracker_og/models/musica_model.dart';
import 'package:ost_tracker_og/service/genero.dart';
import 'package:ost_tracker_og/service/tag.dart';
import 'package:ost_tracker_og/service/usuario.dart';

class MusicaFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UsuarioFirestore _user = UsuarioFirestore();
  final TagFirestore _tag = TagFirestore();
  final GeneroFirestore _genero = GeneroFirestore();

  Future<List<Musica>> musicasToList(
      QuerySnapshot<Map<String, dynamic>> res) async {
    List<Musica> musicas = [];
    for (var musica in res.docs) {
      Map<String, dynamic> map = musica.data();
      map["id"] = musica.id;
      Map<String, dynamic> userMap = await _user.getMusica(map["id"]);
      map["anotacoes"] = userMap["anotacoes"];
      map["generos"] = await Future.wait(List.from(userMap["generos"] ?? [])
          .map((e) async => await _genero.getOnlyGenero(e))
          .toList());
      map["tags"] = await Future.wait(List.from(userMap["tags"] ?? [])
          .map((e) async => await _tag.getOnlyTag(e))
          .toList());
      musicas.add(Musica.fromMap(map));
    }
    return musicas;
  }

  Future<List<Musica>> getMusicas() async {
    var res = await _db
        .collection("/musicas")
        .where(
          Filter.or(
            Filter("dono", isEqualTo: _auth.currentUser!.uid),
            Filter("publico", isEqualTo: true),
          ),
        )
        .get()
        .onError((error, stackTrace) => throw Exception(error));
    return await musicasToList(res);
  }

  saveMusica(Musica musica) async {
    musica.dono = _auth.currentUser!.uid;
    await _db
        .collection("/musicas")
        .add(Musica.toMap(musica))
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) {
      musica.id = value.id;
      _user.saveMusica(musica);
    });
  }

  editMusica(Musica musica) async {
    if (musica.dono != _auth.currentUser!.uid) return;
    await _db
        .doc("/musicas/${musica.id}")
        .update(Musica.toMap(musica))
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) => _user.editMusica(musica));
  }

  deleteMusica(Musica musica) async {
    if (musica.dono != _auth.currentUser!.uid) return;
    await _db
        .doc("/musicas/${musica.id}")
        .delete()
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) => _user.deleteMusica(musica.id));
  }
}
