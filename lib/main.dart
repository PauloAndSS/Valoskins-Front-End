import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const ValoSkinsApp());
}

class ValoSkinsApp extends StatelessWidget {
  const ValoSkinsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ValoSkins',
      debugShowCheckedModeBanner: false, // remove banner de debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple, // cor base moderna
          primary: Colors.deepPurple,
          secondary: Colors.redAccent,
          background: Colors.grey[200], // fundo cinza claro
        ),
        useMaterial3: true, // ativa Material Design 3
      ),
      home: const MainPage(),
    );
  }
}

/// Lista global de páginas e ícones
final List<Map<String, dynamic>> pages = [
  {
    "page": const HomePage(),
    "icon": Icons.home,
    "label": "Home",
  },
  {
    "page": const PlaceholderPage(),
    "icon": Icons.person,
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
      backgroundColor: Colors.grey[200], // fundo cinza claro
      body: pages[_selectedIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple, // cor destaque
        unselectedItemColor: Colors.grey[600], // cor neutra
        backgroundColor: Colors.white, // barra clara
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: pages
            .map(
              (p) => BottomNavigationBarItem(
                icon: Icon(p["icon"]),
                label: p["label"],
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Página placeholder só para evitar erro
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Página de Perfil (placeholder)",
        style: TextStyle(color: Colors.black87, fontSize: 20),
      ),
    );
  }
}
