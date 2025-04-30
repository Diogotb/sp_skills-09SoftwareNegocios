import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _mensagemErro;
  bool _isLoading = false;

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Future<void> _cadastrar() async {
    final email = _emailController.text.trim();
    final senha = _senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      setState(() {
        _mensagemErro = "Preencha todos os campos.";
      });
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() {
        _mensagemErro = "Formato de email inválido.";
      });
      return;
    }

    if (senha.length < 6) {
      setState(() {
        _mensagemErro = "A senha deve ter pelo menos 6 caracteres.";
      });
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      Navigator.pushReplacementNamed(context, "/login");
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'email-already-in-use':
            _mensagemErro = "Este email já está em uso.";
            break;
          case 'weak-password':
            _mensagemErro = "A senha é muito fraca.";
            break;
          case 'invalid-email':
            _mensagemErro = "Formato de email inválido.";
            break;
          default:
            _mensagemErro = "Erro ao cadastrar. Tente novamente.";
        }
      });
    } catch (e) {
      setState(() {
        _mensagemErro = "Erro inesperado. Tente novamente.";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            if (_mensagemErro != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _mensagemErro!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            TextField(
              controller: _emailController,
              decoration: _inputDecoration("Email", Icons.email),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _senhaController,
              decoration: _inputDecoration("Senha", Icons.lock),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Cadastrar"),
              onPressed: _isLoading ? null : _cadastrar,
            ),
          ],
        ),
      ),
    );
  }
}
