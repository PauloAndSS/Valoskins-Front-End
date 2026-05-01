import 'package:flutter/material.dart';
import '../models/skins_model.dart';
import '../components/cards_skins.dart';
import '../api/valo_skins_api.dart';
import 'search_results.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Skin>> futureSkins;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureSkins = ValoSkinsApi.fetchSkins();
  }

  void _onSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SearchResultsPage(query: query),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SEARCH BAR ESTILIZADA
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1230),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Pesquisar skins...",
                  hintStyle: const TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                  prefixIcon:
                      const Icon(Icons.search, color: Colors.white54),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white54, size: 16),
                    onPressed: _onSearch,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onSubmitted: (_) => _onSearch(),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // LISTA
          Expanded(
            child: FutureBuilder<List<Skin>>(
              future: futureSkins,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro: ${snapshot.error}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "Nenhuma skin encontrada",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final skins = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      // CONTADOR
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${skins.length} skins disponíveis",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const Icon(Icons.grid_view,
                              color: Colors.white54),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // GRID
                      Expanded(
                        child: GridView.builder(
                          itemCount: skins.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.72, // 🔥 IMPORTANTE
                          ),
                          itemBuilder: (context, index) {
                            return SkinCard(
                              skin: skins[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}