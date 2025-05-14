import 'package:flutter/material.dart';
import 'package:api_projeto/routes/app_routes.dart'; // Importa as rotas

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicativo Login/Cadastro',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute:
      AppRoutes.login, // Usa a constante para a rota inicial
      routes: AppRoutes.routes, // Usa o mapa de rotas definido em AppRoutes
      debugShowCheckedModeBanner:
      false, // Remove a faixa de debug em modo de desenvolvimento
    );
  }
}

