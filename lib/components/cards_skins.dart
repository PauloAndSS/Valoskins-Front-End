import 'package:flutter/material.dart';
import '../models/skins_model.dart';
import '../pages/details/skin_details.dart';

class SkinCard extends StatelessWidget {
  final Skin skin;

  const SkinCard({super.key, required this.skin});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxHeight < 250;

        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SkinDetailsPage(skin: skin),
              ),
            );
          },
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                // IMAGEM
                Expanded(
                  flex: 2,
                  child: Hero(
                    tag: skin.icone,
                    child: Image.network(
                      skin.icone,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.black26,
                          child: const Center(
                            child: Icon(Icons.broken_image,
                                color: Colors.white70, size: 40),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                            child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),

                // CONTEÚDO
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF3B2559), Color(0xFF1E1233)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // NOME
                        Text(
                          skin.nome,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // RARIDADE + PACOTE
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 14),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                skin.raridade,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 12),
                              ),
                            ),
                            if (!isSmall) ...[
                              const SizedBox(width: 8),
                              const Icon(Icons.category,
                                  color: Colors.pinkAccent, size: 14),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  skin.pacote,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 12),
                                ),
                              ),
                            ]
                          ],
                        ),

                        const SizedBox(height: 6),

                        // PREÇO
                        Text(
                          "R\$ ${skin.preco}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 35, 217, 83),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                        const Spacer(),

                        // LINHA INFERIOR (RESPONSIVA)
                        if (!isSmall)
                          Row(
                            children: [
                              const Icon(Icons.sports_martial_arts,
                                  color: Colors.lightBlueAccent, size: 14),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  skin.arma.nome.isNotEmpty
                                      ? skin.arma.nome
                                      : "Arma desconhecida",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.layers,
                                  color: Colors.greenAccent, size: 14),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  skin.arma.categoria.isNotEmpty
                                      ? skin.arma.categoria
                                      : "Categoria não definida",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}