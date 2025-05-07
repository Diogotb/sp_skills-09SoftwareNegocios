import 'package:flutter/material.dart';

import '../screens/bem_vindo.dart';
import '../screens/cadastro.dart';

class AppRoutes {
  static const String login = '/';
  static const String cadastro = '/cadastro';
  static const String bem_vindo = '/bem_vindo';

  static var home;

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => LoginScreen(),
    cadastro: (context) => CadastroScreen(),
    bem_vindo: (context) => WelcomeScreen(),
  }
}