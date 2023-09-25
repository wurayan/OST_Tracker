class Tag {
  String id;
  String nome;
  String descricao;
  String dono;
  bool publico;

  Tag(
      {required this.id,
      required this.nome,
      required this.descricao,
      required this.dono,
      required this.publico});

  static Tag addTag =
      Tag(id: "", nome: "ADD", descricao: "", dono: "", publico: true);

  static Tag tagEllipsis =
      Tag(id: "", nome: "...", descricao: "", dono: "", publico: true);

  @override
  String toString() {
    return "$id\n$nome\n$dono";
  }

  Tag.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nome = map["nome"],
        descricao = map["descricao"],
        dono = map["dono"],
        publico = map["publico"];

  static Map<String, dynamic> toTag(Tag tag) => {
        "nome": tag.nome,
        "descricao": tag.descricao,
        "dono": tag.dono,
        "publico": tag.publico
      };

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is Tag &&
        other.id == id &&
        other.nome == nome &&
        other.dono == dono &&
        other.publico == publico;
  }

  @override
  int get hashCode => Object.hash(id, nome, dono);
}
