import 'package:flutter/material.dart';
import '../models/skins_model.dart';
import '../components/cards_skins.dart';
import '../api/valo_skins_api.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late Future<List<Skin>> futureResults;

  @override
  void initState() {
    super.initState();
    futureResults = ValoSkinsApi.searchSkinsByName(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0A1F),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Busca",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: FutureBuilder<List<Skin>>(
        future: futureResults,
        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ERRO
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro: ${snapshot.error}",
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final results = snapshot.data ?? [];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔎 QUERY
                Text(
                  "Resultados para",
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "\"${widget.query}\"",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // 📊 CONTADOR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${results.length} encontrados",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const Icon(Icons.search, color: Colors.white54),
                  ],
                ),

                const SizedBox(height: 16),

                // ❌ SEM RESULTADO
                if (results.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.search_off,
                              size: 60, color: Colors.white30),
                          SizedBox(height: 12),
                          Text(
                            "Nenhuma skin encontrada",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  // GRID
                  Expanded(
                    child: GridView.builder(
                      itemCount: results.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72, // 🔥 alinhado com Home
                      ),
                      itemBuilder: (context, index) {
                        return SkinCard(
                          skin: results[index],
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}