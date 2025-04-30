import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist/Lista.dart';
import 'package:todolist/Cadastro.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
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
      if (_usuarioController.text.isEmpty || !_usuarioController.text.contains('@')) {
        throw FirebaseAuthException(
            code: 'invalid-email', message: "Por favor, insira um e-mail válido.");
      }

      if (_senhaController.text.isEmpty || _senhaController.text.length < 6) {
        throw FirebaseAuthException(
            code: 'weak-password', message: "A senha deve ter pelo menos 6 caracteres.");
      }

      await _auth.signInWithEmailAndPassword(
        email: _usuarioController.text.trim(),
        password: _senhaController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ListaTarefas()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _erro = e.message ?? "Erro ao fazer login.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_erro != null)
              Text(
                _erro!,
                style: TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _usuarioController,
              decoration: InputDecoration(labelText: "E-mail", prefixIcon: Icon(Icons.email)),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: "Senha", prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Entrar"),
              onPressed: _isLoading ? null : _login,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/Cadastro");
              },
              child: Text("Criar Conta"),
            )
          ],
        ),
      ),
    );
  }
}
