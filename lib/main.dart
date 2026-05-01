import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/profile.dart';
void main() {
  runApp(const ValoSkinsApp());
}

class ValoSkinsApp extends StatelessWidget {
  const ValoSkinsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ValoSkins',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0A1F),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7B61FF),
          secondary: Color(0xFFD92344),
        ),
      ),
      home: const MainPage(),
    );
  }
}

/// PÁGINAS
final List<Map<String, dynamic>> pages = [
  {"page": const HomePage(), "icon": Icons.home_rounded, "label": "Home"},
  {
    "page": const ProfilePage(),
    "icon": Icons.person_rounded,
    "label": "Perfil",
  },
];

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔥 CONTEÚDO COM ESPAÇO PRO HEADER
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: pages[_selectedIndex]["page"],
          ),

          // 🔥 HEADER GLOBAL MODERNO
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1230).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // TÍTULO DINÂMICO
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF7B61FF), Color(0xFFD92344)],
                          ).createShader(bounds),
                          child: const Text(
                            "VALOSKINS",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                              color: Colors
                                  .white, // necessário pro shader funcionar
                            ),
                          ),
                        ),
                      ],
                    ),
                    // AÇÕES
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF7B61FF).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.person,
                            size: 18,
                            color: Color(0xFF7B61FF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔥 NAV BAR MODERNA
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1230).withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(pages.length, (index) {
                  final isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF7B61FF).withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            pages[index]["icon"],
                            color: isSelected
                                ? const Color(0xFF7B61FF)
                                : Colors.white54,
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 6),
                            Text(
                              pages[index]["label"],
                              style: const TextStyle(
                                color: Color(0xFF7B61FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// PLACEHOLDER
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Perfil em construção 🚧",
        style: TextStyle(color: Colors.white70, fontSize: 18),
      ),
    );
  }
}
