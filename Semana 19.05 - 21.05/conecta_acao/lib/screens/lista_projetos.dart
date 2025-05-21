import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Projeto {
  final int idProjeto;
  final String nomeProjeto;
  final String descricao;
  final int idAreaAtuacao;
  final bool status; // Booleano
  final double fatorCriticidade;
  final String localizacao;
  final DateTime dataInicio;
  final DateTime dataFimPrevista;

  const Projeto({
    required this.idProjeto,
    required this.nomeProjeto,
    required this.descricao,
    required this.idAreaAtuacao,
    required this.status,
    required this.fatorCriticidade,
    required this.localizacao,
    required this.dataInicio,
    required this.dataFimPrevista,
  });

  factory Projeto.fromJson(Map<String, dynamic> json) {
    bool parsedStatus;
    if (json['status'] is String) {
      parsedStatus = json['status'].toLowerCase() == 'ativo';
    } else {
      parsedStatus = json['status'] ?? false;
    }
    DateTime parsedDataInicio;
    try {
      parsedDataInicio = DateTime.parse(json['dataInicio']);
    } catch (e) {
      print('Erro ao parsear dataInicio: ${json['dataInicio']} - $e');
      parsedDataInicio = DateTime.now();
    }

    DateTime parsedDataFimPrevista;
    try {
      parsedDataFimPrevista = DateTime.parse(json['dataFimPrevista']);
    } catch (e) {
      print('Erro ao parsear dataFimPrevista: ${json['dataFimPrevista']} - $e');
      parsedDataFimPrevista = DateTime.now();
    }


    return Projeto(
      idProjeto: json['idProjeto'] as int,
      nomeProjeto: json['nomeProjeto'] as String,
      descricao: json['descricao'] as String,
      idAreaAtuacao: json['idAreaAtuacao'] as int,
      status: parsedStatus,
      fatorCriticidade: (json['fatorCriticidade'] as num).toDouble(),
      localizacao: json['localizacao'] as String,
      dataInicio: parsedDataInicio,
      dataFimPrevista: parsedDataFimPrevista,
    );
  }
}

Future<List<Projeto>> fetchProjetos() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:3000/projetos'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList.map((json) => Projeto.fromJson(json as Map<String, dynamic>)).toList();
  } else {
    throw Exception('Falhou em carregar os Projetos: Status Code ${response.statusCode}');
  }
}

class ListaProjetosScreen extends StatefulWidget {
  const ListaProjetosScreen({Key? key}) : super(key: key);

  @override
  _ListaProjetosScreenState createState() => _ListaProjetosScreenState();
}

class _ListaProjetosScreenState extends State<ListaProjetosScreen> {
  late Future<List<Projeto>> _futureProjetos;

  @override
  void initState() {
    super.initState();
    _futureProjetos = fetchProjetos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Projetos", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.blueGrey[900],
        child: FutureBuilder<List<Projeto>>(
          future: _futureProjetos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.white,));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Erro: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum projeto encontrado.',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final projeto = snapshot.data![index];
                  return Card(
                    color: Colors.deepPurple[700],
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            projeto.nomeProjeto,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            projeto.descricao,
                            style: const TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Localização: ${projeto.localizacao}',
                            style: const TextStyle(fontSize: 14, color: Colors.white60),
                          ),
                          Text(
                            'Status: ${projeto.status ? 'Ativo' : 'Inativo'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: projeto.status ? Colors.greenAccent : Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Início: ${projeto.dataInicio.day}/${projeto.dataInicio.month}/${projeto.dataInicio.year}',
                            style: const TextStyle(fontSize: 14, color: Colors.white60),
                          ),
                          Text(
                            'Previsão Fim: ${projeto.dataFimPrevista.day}/${projeto.dataFimPrevista.month}/${projeto.dataFimPrevista.year}',
                            style: const TextStyle(fontSize: 14, color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'Inicie o carregamento dos projetos.',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}