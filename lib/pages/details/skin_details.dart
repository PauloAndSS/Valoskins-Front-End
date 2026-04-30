import 'package:flutter/material.dart';
import '../../models/skins_model.dart';

class SkinDetailsPage extends StatelessWidget {
  final Skin skin;

  const SkinDetailsPage({super.key, required this.skin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(skin.nome),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem principal
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                skin.icone,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              "Raridade: ${skin.raridade}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("Pacote: ${skin.pacote}"),
            Text("Preço: ${skin.preco}"),
            const SizedBox(height: 16),

            Text(
              "Arma: ${skin.arma.nome} (${skin.arma.categoria})",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16),

            const Text(
              "Comentários:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: skin.comentarios.length,
                itemBuilder: (context, index) {
                  final comentario = skin.comentarios[index];
                  return ListTile(
                    title: Text(comentario.descricao),
                    subtitle: Text("Curtidas: ${comentario.curtidas}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
