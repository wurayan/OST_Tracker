class Artista {
  String id;
  String nome;
  List<String> generos;
  String dono;
  bool publico;

  Artista(
      {required this.id,
      required this.nome,
      required this.generos,
      required this.dono,
      required this.publico});

  @override
  String toString() {
    return nome;
  }

  Artista.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nome = map["nome"],
        generos = List.from(map["generos"]),
        // map["generos"],
        dono = map["dono"],
        publico = map["publico"];

  static toMap(Artista artista) => {
        "nome": artista.nome,
        "generos": artista.generos,
        "dono": artista.dono,
        "publico": artista.publico,
      };
}
