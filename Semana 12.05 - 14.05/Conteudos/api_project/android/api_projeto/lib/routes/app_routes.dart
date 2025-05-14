import 'package:flutter/material.dart';

import '../screens/movie_management.dart';
import '../screens/cadastro.dart';
import '../screens/login.dart';

class AppRoutes {
  static const String login = '/';
  static const String cadastro = '/cadastro';
  static const String movie = '/movie';

  static var home;

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => LoginScreen(),
    cadastro: (context) => CadastroScreen(),
    bemVindo: (context) => const WelcomeScreen(),
  };
}