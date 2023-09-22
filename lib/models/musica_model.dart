import 'package:ost_tracker_og/models/genero_model.dart';
import 'package:ost_tracker_og/models/tag_model.dart';

class Musica {
  String id;
  String nome;
  String artista;
  String link;
  String? anotacoes;
  List<Genero> generos;
  List<Tag>? tags;
  String dono;
  bool publico;

  Musica(
      {required this.id,
      required this.nome,
      required this.artista,
      required this.link,
      this.anotacoes,
      required this.generos,
      this.tags,
      required this.dono,
      required this.publico});

  @override
  String toString() {
    return "$nome \n $artista \n $link \n $anotacoes";
  }

  Musica.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nome = map["nome"],
        artista = map["artista"],
        link = map["link"],
        anotacoes = map["anotacoes"]??"",
        generos = map["generos"],
        // map["generos"] as List<String>,
        tags = map["tags"],
        // map["tags"]??[] as List<String>,
        dono = map["dono"],
        publico = map["publico"];

  static Map<String, dynamic> toMap(Musica musica) {
    return {
      "nome": musica.nome,
      "artista": musica.artista,
      "link": musica.link,
      "dono": musica.dono,
      "publico": musica.publico
    };
  }
}
