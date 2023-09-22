import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/service/usuario.dart';

class GeneroFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UsuarioFirestore _user = UsuarioFirestore();

  Future<Genero> getOnlyGenero(String id) async {
    var res = await _db
        .doc("/generos/$id")
        .get()
        .onError((error, stackTrace) => throw Exception(error));
    Map<String, dynamic>? map = res.data();
    if (map == null) return Genero.addGenero;
    map["id"] = id;
    return Genero.fromMap(map);
  }

  Future<List<Genero>> getGeneros() async {
    List<Genero> generos = [];
    var res = await _db
        .collection("/generos")
        .where(Filter.or(Filter("dono", isEqualTo: _auth.currentUser!.uid),
            Filter("publico", isEqualTo: true)))
        .get()
        .onError((error, stackTrace) => throw Exception(error));
    for (var genero in res.docs) {
      Map<String, dynamic> map = genero.data();
      map["id"] = genero.id;
      generos.add(Genero.fromMap(map));
    }
    return generos;
  }

  Future<void> saveGenero(Genero genero) async {
    genero.dono = _auth.currentUser!.uid;
    await _db
        .collection("/generos")
        .add(Genero.toMap(genero))
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) => _user.saveGenero(value.id));
  }

  Future<void> editGenero(Genero genero) async {
    if (genero.dono != _auth.currentUser!.uid) return;
    await _db
        .doc("/generos/${genero.id}")
        .update(Genero.toMap(genero))
        .onError((error, stackTrace) => throw Exception(error));
  }

  Future<void> deleteGenero(Genero genero) async {
    if (genero.dono != _auth.currentUser!.uid) return;
    await _db
        .doc("/generos/${genero.id}")
        .delete()
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) => _user.deleteGenero(genero.id));
  }
}
