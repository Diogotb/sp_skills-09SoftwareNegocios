import 'package:conecta_acao/routes/app_routes.dart';
import 'package:flutter/material.dart';

class HomeComIdScreen extends StatefulWidget {
  const HomeComIdScreen({Key? key}) : super(key: key);

  @override
  _HomeComIdScreenState createState() => _HomeComIdScreenState();
}

class _HomeComIdScreenState extends State<HomeComIdScreen> {
  String nome = '';
  String sobrenome = '';
  bool _argsLoaded = false; // Flag para garantir que os argumentos são carregados apenas uma vez

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_argsLoaded) {
      final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null) {
        setState(() {
          // Verifique se 'nome' e 'sobrenome' existem e atribua.
          // Use '?? '' ' para garantir que não haverá erro se um deles for nulo.
          nome = args['nome'] ?? '';
          sobrenome = args['sobrenome'] ?? '';
        });
        _argsLoaded = true; // Define a flag como true após carregar os argumentos
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bem vindo ao Conecta Ação",
          style: TextStyle(color: Colors.white),
        ),
        leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(image: AssetImage('img/alphabet.png'))
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueGrey[900],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              // Agora $nome e $sobrenome serão atualizados após setState
              Text(
                "Bem Vindo a Conecta Ação!!, Seja Bem-Vindo $nome $sobrenome, Escolha a Forma que você pode nos ajudar",
                textAlign: TextAlign.center,
                style: const TextStyle( // Adicionado 'const' se possível
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 60),
              const Text( // Adicionado 'const'
                "Veja nossos Voluntarios",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.ranking_voluntarios);
                },
                child: const Text("Rank de Voluntarios"), // Adicionado 'const'
              ),
              const SizedBox(height: 20),
              const Text( // Adicionado 'const'
                "Veja nossos Projetos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.lista_projetos);
                },
                child: const Text("Projetos"), // Adicionado 'const'
              ),
              const SizedBox(height: 20),
              const Text( // Adicionado 'const'
                "Veja nosso Dashboard",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.dashboard);
                },
                child: const Text("Dashboard"), // Adicionado 'const'
              )
            ],
          ),
        ),
      ),
    );
  }
}
