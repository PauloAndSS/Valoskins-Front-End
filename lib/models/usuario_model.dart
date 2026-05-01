class Usuario {
  final String idUsuario;
  final String nome;
  final String email;
  final String colecao;

  Usuario({
    required this.idUsuario,
    required this.nome,
    required this.email,
    required this.colecao,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json['id_usuario'] ?? '',
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      colecao: json['colecao'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_usuario": idUsuario,
      "nome": nome,
      "email": email,
      "colecao": colecao,
    };
  }
}
