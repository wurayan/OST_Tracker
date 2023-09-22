import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ost_tracker_og/models/tag_model.dart';
import 'package:ost_tracker_og/service/usuario.dart';

class TagFirestore {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UsuarioFirestore _user = UsuarioFirestore();

  Future<Tag> getOnlyTag(String id) async {
    var res = await _db
        .doc("/tags/$id")
        .get()
        .onError((error, stackTrace) => throw Exception(error));
    Map<String, dynamic>? map = res.data();
    if (map == null) return Tag.addTag;
    map["id"] = id;
    return Tag.fromMap(map);
  }

  Future<List<Tag>> getTags() async {
    List<Tag> tags = [];
    var res = await _db
        .collection("/tags")
        .where(Filter.or(Filter("dono", isEqualTo: _auth.currentUser!.uid),
            Filter("publico", isEqualTo: true)))
        .get()
        .onError((error, stackTrace) => throw Exception(error));
    for (var tag in res.docs) {
      Map<String, dynamic> map = tag.data();
      map["id"] = tag.id;
      tags.add(Tag.fromMap(map));
    }
    return tags;
  }

  Future<void> saveTag(Tag tag) async {
    tag.dono = _auth.currentUser!.uid;
    await _db
        .collection("/tags")
        .add(Tag.toTag(tag))
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) => _user.saveTag(value.id));
  }

  Future<void> editTag(Tag tag) async {
    if (tag.id != _auth.currentUser!.uid) return;
    await _db
        .doc("tags/${tag.id}")
        .update(Tag.toTag(tag))
        .onError((error, stackTrace) => throw Exception(error));
  }

  Future<void> deleteTag(Tag tag) async {
    if (tag.dono != _auth.currentUser!.uid) return;
    await _db
        .doc("tags/${tag.id}")
        .delete()
        .onError((error, stackTrace) => throw Exception(error))
        .then((value) => _user.deleteTag(tag.id));
  }
}
