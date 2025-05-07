import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Certifique-se de importar o arquivo onde ListaTarefas está definido
// Por exemplo:
import 'package:todolist/lista.dart'; // Use o nome do arquivo em letras minúsculas
import 'package:todolist/cadastro.dart'; // Importe a página de cadastro

class LoginPage extends StatefulWidget {
  const LoginPage({super.key}); // Adicione const aqui

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _erro;
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _erro = null;
    });

    try {
      String email = _usuarioController.text.trim();
      String senha = _senhaController.text.trim();

      if (email.isEmpty || !email.contains('@')) {
        setState(() {
          _erro = "Por favor, insira um e-mail válido.";
        });
        return;
      }

      if (senha.isEmpty || senha.length < 6) {
        setState(() {
          _erro = "A senha deve ter pelo menos 6 caracteres.";
        });
        return;
      }

      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      if (userCredential.user != null && userCredential.user!.emailVerified) {
        print("Login realizado com sucesso!");
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => ListaTarefas()), // Use o nome correto da sua página de lista e adicione const se possível
          );
        }
      } else if (userCredential.user != null && !userCredential.user!.emailVerified) {
        setState(() {
          _erro = "Por favor, verifique seu e-mail.";
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _erro = _getErrorMessage(e.code);
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'invalid-email':
        return 'Formato de e-mail inválido.';
      case 'user-disabled':
        return 'Esta conta de usuário foi desativada.';
      default:
        return 'Erro ao fazer login. Tente novamente.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_erro != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  _erro!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            TextField(
              controller: _usuarioController,
              decoration: const InputDecoration(labelText: "E-mail", prefixIcon: Icon(Icons.email)),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: "Senha", prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Entrar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cadastro"); // Use a rota definida no main.dart
              },
              child: const Text("Criar Conta"),
            )
          ],
        ),
      ),
    );
  }
}