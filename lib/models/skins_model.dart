import 'weapons_model.dart';

class Comentario {
  final String descricao;
  final int curtidas;

  Comentario({
    required this.descricao,
    required this.curtidas,
  });

  factory Comentario.fromJson(Map<String, dynamic> json) {
    return Comentario(
      descricao: json['descricao'] as String,
      curtidas: json['curtidas'] as int,
    );
  }
}

class Skin {
  final String idSkin;
  final String nome;
  final String raridade;
  final String icone;
  final String preco;
  final String pacote;
  final Arma arma; // objeto completo
  final List<Comentario> comentarios;

  Skin({
    required this.idSkin,
    required this.nome,
    required this.raridade,
    required this.icone,
    required this.preco,
    required this.pacote,
    required this.arma,
    required this.comentarios,
  });
factory Skin.fromJson(Map<String, dynamic> json) {
  var comentariosJson = json['comentarios'];
  List<Comentario> comentariosList = [];
  if (comentariosJson is List) {
    comentariosList = comentariosJson
        .where((c) => c is Map<String, dynamic>)
        .map((c) => Comentario.fromJson(c as Map<String, dynamic>))
        .toList();
  }

  Arma armaObj;
  if (json['arma'] is Map<String, dynamic>) {
    armaObj = Arma.fromJson(json['arma']);
  } else {
    // Se vier só o id_arma como string
    armaObj = Arma(
      idArma: json['arma'].toString(),
      nome: '',
      categoria: '',
    );
  }

  return Skin(
    idSkin: json['id_skin'] ?? '',
    nome: json['nome'] ?? '',
    raridade: json['raridade'] ?? '',
    icone: json['icone'] ?? '',
    preco: json['preco'] ?? '',
    pacote: json['pacote'] ?? '',
    arma: armaObj,
    comentarios: comentariosList,
  );
}

}
