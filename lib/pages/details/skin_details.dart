import 'package:flutter/material.dart';
import '../../models/skins_model.dart';

class SkinDetailsPage extends StatelessWidget {
  final Skin skin;

  const SkinDetailsPage({super.key, required this.skin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0A1F),
      body: CustomScrollView(
        slivers: [
          // APP BAR COM IMAGEM
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                skin.nome,
                style: const TextStyle(fontSize: 16),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: skin.icone,
                    child: Image.network(
                      skin.icone,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Overlay escuro (gradiente)
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Color(0xFF0F0A1F),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // CONTEÚDO
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // INFO PRINCIPAL
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1230),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                skin.raridade,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const Icon(Icons.category,
                                color: Colors.pinkAccent),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                skin.pacote,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            const Icon(Icons.attach_money,
                                color: Color.fromARGB(255, 35, 217, 83)),
                            const SizedBox(width: 6),
                            Text(
                              skin.preco.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 35, 217, 83),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ARMA
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1230),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.sports_martial_arts,
                            color: Colors.lightBlueAccent),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            skin.arma.nome.isNotEmpty
                                ? skin.arma.nome
                                : "Arma desconhecida",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const Icon(Icons.layers,
                            color: Colors.greenAccent),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            skin.arma.categoria.isNotEmpty
                                ? skin.arma.categoria
                                : "Categoria não definida",
                            style:
                                const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // COMENTÁRIOS TÍTULO
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Comentários",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // LISTA DE COMENTÁRIOS
                  ListView.builder(
                    itemCount: skin.comentarios.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final comentario = skin.comentarios[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1230),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.comment,
                                color: Colors.white54, size: 20),
                            const SizedBox(width: 10),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comentario.descricao,
                                    style: const TextStyle(
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.thumb_up,
                                          size: 14,
                                          color: Colors.greenAccent),
                                      const SizedBox(width: 4),
                                      Text(
                                        comentario.curtidas.toString(),
                                        style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}