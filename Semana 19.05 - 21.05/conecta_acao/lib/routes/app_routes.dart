import 'package:flutter/material.dart';
import '../screens/cadastro.dart';
import '../screens/login.dart';
import '../screens/tela_home_sem_id.dart';
import '../screens/tela_home_id_identificado.dart';
import '../screens/lista_projetos.dart';
import '../screens/ranking_voluntarios.dart';
import '../screens/dashboard.dart';

// defini as rotas da pagina no caso de ser web
class AppRoutes {
  static const String home_sem_id = '/';
  static const String cadastro = '/cadastro';
  static const String login = '/login';
  static const String tela_home_com_id = '/home';
  static const String ranking_voluntarios = '/rank';
  static const String lista_projetos = '/lista';
  static const String dashboard = '/dashboard';

  static var home_com_id;

  // defini as rotas para as outras telas no android
  static Map<String, WidgetBuilder> get routes => {
    login: (context) => LoginScreen(),
    cadastro: (context) => CadastroScreen(),
    home_sem_id: (context) => const HomeSemIdScreen(),
    tela_home_com_id: (context) => const HomeComIdScreen(),
    lista_projetos: (context) => const ListaProjetosScreen(),
    ranking_voluntarios: (context) => const RankScreen(),
    dashboard: (context) => const DashboardScreen(),
  };

}