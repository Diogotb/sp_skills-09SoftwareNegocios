import 'package:api_projeto/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});  // Construtor constante adicionado

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo Login/Cadastro',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.login,  // Corrigido para rota existente
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,  // Remove banner de debug
    );
  }
}