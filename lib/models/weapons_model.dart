class Arma {
  final String idArma;
  final String nome;
  final String categoria;

  Arma({
    required this.idArma,
    required this.nome,
    required this.categoria,
  });

  factory Arma.fromJson(Map<String, dynamic> json) {
    return Arma(
      idArma: json['id_arma'],
      nome: json['nome'],
      categoria: json['categoria'],
    );
  }
}
