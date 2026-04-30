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

  /// Busca todas as skins
  static Future<List<Skin>> fetchSkins() async {
    final response = await http.get(Uri.parse("$baseUrl/skins"));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded.map((json) => Skin.fromJson(json)).toList();
      }

      if (decoded is Map<String, dynamic>) {
        return [Skin.fromJson(decoded)];
      }

      throw Exception("Formato inesperado ao carregar skins");
    } else {
      throw Exception("Erro ao carregar skins: ${response.statusCode}");
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
