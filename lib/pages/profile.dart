import 'package:flutter/material.dart';
import '../api/valo_skins_api.dart' hide Usuario; // importa a API que criamos
import '../models/usuario_model.dart'; // separamos o model Usuario
import 'home.dart'; // sua página inicial

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Usuario? usuario; // guarda o usuário logado

  @override
  void initState() {
    super.initState();
    usuario = UsuarioApi.getUsuarioLogado() as Usuario?; // recupera da sessão
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = usuario != null;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1233),
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: const Color(0xFF3B2559),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.purple.shade300,
              child: Icon(
                isLoggedIn ? Icons.person : Icons.person_outline,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isLoggedIn
                  ? "Bem-vindo, ${usuario!.nome}"
                  : "Visitante",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            if (!isLoggedIn)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD92344),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      _showRegisterDialog(context);
                    },
                    child: const Text("Cadastrar"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6F36BF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      _showLoginDialog(context);
                    },
                    child: const Text("Entrar"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Popup de Cadastro
  void _showRegisterDialog(BuildContext context) {
    final nomeController = TextEditingController();
    final emailController = TextEditingController();
    final senhaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFF2A1B47),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Cadastro",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 20),
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(hintText: "Nome"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: "Senha"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final usuarioCadastrado = await UsuarioApi.cadastrar(
                        nomeController.text,
                        emailController.text,
                        senhaController.text,
                      ) as Usuario?;
                      setState(() {
                        usuario = usuarioCadastrado;
                      });
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Erro: $e")),
                      );
                    }
                  },
                  child: const Text("Cadastrar"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Popup de Login
  void _showLoginDialog(BuildContext context) {
    final emailController = TextEditingController();
    final senhaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFF2A1B47),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: "Senha"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final usuarioLogado = await UsuarioApi.login(
                        emailController.text,
                        senhaController.text,
                      ) as Usuario?;
                      setState(() {
                        usuario = usuarioLogado;
                      });
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Erro: $e")),
                      );
                    }
                  },
                  child: const Text("Entrar"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
