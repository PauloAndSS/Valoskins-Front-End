import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weapons_model.dart';
import '../models/skins_model.dart';

class ValoSkinsApi {
  static const String baseUrl = "http://127.0.0.1:8000/api";

  /// Busca todas as armas
  static Future<List<Arma>> fetchArmas() async {
    final response = await http.get(Uri.parse("$baseUrl/armas"));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      // Se vier lista
      if (decoded is List) {
        return decoded.map((json) => Arma.fromJson(json)).toList();
      }

      // Se vier objeto único
      if (decoded is Map<String, dynamic>) {
        return [Arma.fromJson(decoded)];
      }

      throw Exception("Formato inesperado ao carregar armas");
    } else {
      throw Exception("Erro ao carregar armas: ${response.statusCode}");
    }
  }

  static Future<List<Map<String, dynamic>>> fetchComentarios() async {
  final response = await http.get(Uri.parse("$baseUrl/comentarios"));

  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  } else {
    throw Exception("Erro ao carregar comentários");
  }
}

static Future<List<Map<String, dynamic>>> fetchCurtidas() async {
  final response = await http.get(Uri.parse("$baseUrl/curtidas"));

  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  } else {
    throw Exception("Erro ao carregar curtidas");
  }
}

  /// Busca todas as skins
  static Future<List<Skin>> fetchSkins() async {
  final skinsRes = await http.get(Uri.parse("$baseUrl/skins"));
  final comentarios = await fetchComentarios();
  final curtidas = await fetchCurtidas();

  if (skinsRes.statusCode == 200) {
    final decoded = jsonDecode(skinsRes.body);

    List<Map<String, dynamic>> skinsJson =
        List<Map<String, dynamic>>.from(decoded);

    return skinsJson.map((skinJson) {
      final skinId = skinJson['id_skin'];

      // 🔥 Filtra comentários da skin
      final comentariosDaSkin = comentarios
          .where((c) => c['skin'] == skinId)
          .map((c) {
            final idComentario = c['id_comentario'];

            // 🔥 Conta curtidas desse comentário
            final totalCurtidas = curtidas
                .where((cu) => cu['comentario'] == idComentario)
                .length;

            return {
              "descricao": c['descricao'],
              "curtidas": totalCurtidas,
            };
          })
          .toList();

      // 🔥 Injeta comentários na skin
      skinJson['comentarios'] = comentariosDaSkin;

      return Skin.fromJson(skinJson);
    }).toList();
  } else {
    throw Exception("Erro ao carregar skins");
  }
}

  /// Busca skins por nome
  static Future<List<Skin>> searchSkinsByName(String query) async {
    final response = await http.get(Uri.parse("$baseUrl/skins"));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      List<Skin> skins = [];
      if (decoded is List) {
        skins = decoded.map((json) => Skin.fromJson(json)).toList();
      } else if (decoded is Map<String, dynamic>) {
        skins = [Skin.fromJson(decoded)];
      }

      // Filtra skins que contém o termo no nome
      List<Skin> filtered = skins.where((skin) =>
          skin.nome.toLowerCase().contains(query.toLowerCase())).toList();

      // Ordena pela posição da substring no nome
      filtered.sort((a, b) {
        int posA = a.nome.toLowerCase().indexOf(query.toLowerCase());
        int posB = b.nome.toLowerCase().indexOf(query.toLowerCase());
        return posA.compareTo(posB);
      });

      return filtered;
    } else {
      throw Exception("Erro ao buscar skins: ${response.statusCode}");
    }
  }

  /// Busca skins de uma arma específica
  static Future<List<Skin>> fetchSkinsByArma(String idArma) async {
    final response = await http.get(Uri.parse("$baseUrl/skins?arma=$idArma"));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded.map((json) => Skin.fromJson(json)).toList();
      }

      if (decoded is Map<String, dynamic>) {
        return [Skin.fromJson(decoded)];
      }

      throw Exception("Formato inesperado ao carregar skins da arma");
    } else {
      throw Exception("Erro ao carregar skins da arma: ${response.statusCode}");
    }
  }
}

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
}

class UsuarioApi {
  static const String baseUrl = "http://127.0.0.1:8000/api/usuarios";

  /// Variável global de sessão
  static Usuario? usuarioLogado;

  /// Cadastro de usuário
  static Future<Usuario> cadastrar(
      String nome, String email, String senha) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nome": nome,
        "email": email,
        "senha": senha, // idealmente backend deve criptografar
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final usuario = Usuario.fromJson(decoded);
      usuarioLogado = usuario; // salva na sessão
      return usuario;
    } else {
      throw Exception("Erro ao cadastrar: ${response.statusCode}");
    }
  }

  /// Login de usuário
  static Future<Usuario> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "senha": senha,
      }),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final usuario = Usuario.fromJson(decoded);
      usuarioLogado = usuario; // salva na sessão
      return usuario;
    } else {
      throw Exception("Erro ao logar: ${response.statusCode}");
    }
  }

  /// Recupera usuário da sessão
  static Usuario? getUsuarioLogado() {
    return usuarioLogado;
  }

  /// Logout
  static void logout() {
    usuarioLogado = null;
  }
}