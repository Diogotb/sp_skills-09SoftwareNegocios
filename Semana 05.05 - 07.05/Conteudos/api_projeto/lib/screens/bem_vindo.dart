import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          title: Text('Bem-Vindo'),
          inputDecoration:backgroundColor.red,
        )
      )
    );
  }
}

mixin backgroundColor {
}