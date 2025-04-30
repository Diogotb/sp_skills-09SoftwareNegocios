import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolist/Lista.dart';
import 'package:todolist/login.dart';
import 'package:todolist/Cadastro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(); // Inicialização do Firebase
    print('Firebase inicializado com sucesso!');
  } catch (e) {
    print('Erro ao inicializar o Firebase: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      home: LoginPage(), // Página inicial do app
      routes: {
        '/login': (context) => LoginPage(),
        '/Cadastro': (context) => CadastroPage(),
        '/Lista': (context) => ListaPage(), // Adicionado para Lista
      },
    );
  }
}
