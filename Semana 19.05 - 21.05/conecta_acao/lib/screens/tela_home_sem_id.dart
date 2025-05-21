import 'package:conecta_acao/routes/app_routes.dart';
import 'package:flutter/material.dart';

class  HomeSemIdScreen extends StatefulWidget{
  const HomeSemIdScreen ({Key? key}) : super(key: key);
  
  @override
  _HomeSemIdScreenState createState() => _HomeSemIdScreenState();
}

class _HomeSemIdScreenState extends State<HomeSemIdScreen> {
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
              const Text(
                "Bem Vindo a Conecta Ação!!, Seja Bem-Vindo Convidado, Escolha a Forma que você pode nos ajudar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 60),
              Text(
                "Melhore a sua experiencia Fazendo Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(onPressed: (){ Navigator.pushNamed(context, AppRoutes.login);}, child: Text("Login")),
              const SizedBox(height: 20),
              Text(
                  "Veja nossos Voluntarios",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                  ),
              ),
              ElevatedButton(onPressed: () { Navigator.pushNamed(context, AppRoutes.ranking_voluntarios);}, child: Text("Rank de Voluntarios")),
              const SizedBox(height: 20),
              Text(
                "Veja nossos Projetos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(onPressed: () { Navigator.pushNamed(context, AppRoutes.lista_projetos);}, child: Text("Projetos")),
              const SizedBox(height: 20),
              Text(
                "Veja nosso Dashboard",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(onPressed: () {Navigator.pushNamed(context, AppRoutes.dashboard);}, child: Text("Dashboard"))
            ],
          ),
        ),
      ),
    );
  }
}