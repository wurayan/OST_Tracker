class Playlist {
  String id;
  String nome;
  String descricao;
  String dono;
  List<String> idMusicas;

  Playlist(
      {required this.id,
      required this.nome,
      required this.descricao,
      required this.dono,
      required this.idMusicas});

  @override
  String toString() {
    return "$nome \n $descricao \n $idMusicas";
  }

  Playlist.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nome = map["nome"],
        descricao = map["descricao"],
        dono = map["dono"],
        idMusicas = List.from(map["idMusicas"]);
  // map["idMusicas"];

  static Map<String,dynamic> toMap(Playlist playlist) => {
    "nome" : playlist.nome,
    "descricao" : playlist.descricao,
    "dono" : playlist.dono,
    "idMusicas" : playlist.idMusicas,
  };
}
