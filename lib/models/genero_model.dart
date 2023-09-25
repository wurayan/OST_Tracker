class Genero {
  String id;
  String nome;
  String dono;
  bool publico;

  Genero(
      {required this.id,
      required this.nome,
      required this.dono,
      required this.publico});

  static Genero addGenero =
      Genero(id: "", nome: "ADD", dono: "", publico: true);

  static Genero generoEllipsis =
      Genero(id: "", nome: "...", dono: "", publico: true);

  Genero.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nome = map["nome"],
        dono = map["dono"],
        publico = map["publico"];

  static Map<String, dynamic> toMap(Genero genero) => {
        "nome": genero.nome,
        "dono": genero.dono,
        "publico": genero.publico,
      };

  @override
  String toString() {
    return "$id\n$nome\n$dono";
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is Genero &&
        other.id == id &&
        other.nome == nome &&
        other.dono == dono &&
        other.publico == publico;
  }

  @override
  int get hashCode => Object.hash(id, nome, dono);
}
