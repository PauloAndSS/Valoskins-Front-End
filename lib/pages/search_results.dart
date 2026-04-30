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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Resultados: ${widget.query}"),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<Skin>>(
        future: futureResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhuma skin encontrada"));
          }

          final results = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: results.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 4 / 3,
              ),
              itemBuilder: (context, index) {
                return SkinCard(skin: results[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
