import 'package:flutter/material.dart';
import '../screens/login.dart';
import '../screens/cadastro.dart';
import '../screens/movie_management.dart';
import '../screens/home.dart';

class AppRoutes {
  static const String login = '/';
  static const String cadastro = '/cadastro';
  static const String movieManagement = '/movie-management';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginScreen(),
    cadastro: (context) => const CadastroScreen(),
    movieManagement: (context) => const MovieManagementScreen(),
    home: (context) => const HomeScreen(),
  };
}
