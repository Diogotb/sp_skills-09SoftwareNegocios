import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:conecta_acao/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen ({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sobrenomeController = TextEditingController();
  final _senhaController = TextEditingController();

  bool _obscureSenha = true;
  bool _isLoading = false;
  final String _apiUrl = 'http://10.0.2.2:3000'; // Certifique-se de que esta URL está correta para o seu backend

  @override
  void dispose(){
    _sobrenomeController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _loginUsuario() async {
    // Valida os campos do formulário
    if (! _formKey.currentState!.validate()){
      return; // Se a validação falhar, interrompe o processo de login
    }

    // Define o estado de carregamento como verdadeiro para mostrar um indicador de progresso
    setState(() => _isLoading = true);

    try {
      // Envia uma requisição POST para o endpoint de login da API
      final response = await http.post(
        Uri.parse('$_apiUrl/login'),
        headers: {'Content-Type' : 'application/json'}, // Especifica o tipo de conteúdo como JSON
        body: jsonEncode({
          'sobrenome': _sobrenomeController.text.trim(), // Obtém o sobrenome do controlador (sem espaços extras)
          'senha': _senhaController.text.trim(), // Obtém a senha do controlador (sem espaços extras)
        }),
      );

      // Verifica o código de status da resposta
      if (response.statusCode == 200) {
        // Mostra mensagem de sucesso
        _showSuccess('Login realizado com sucesso!!!');
        // Navega para a tela inicial, substituindo a rota atual
        Navigator.pushReplacementNamed(context, AppRoutes.tela_home_com_id);
      } else {
        // Analisa a resposta de erro do backend
        final responseData = jsonDecode(response.body);
        // Obtém a mensagem de erro, ou usa uma padrão se não for fornecida
        String errorMessage = responseData['error'] ?? 'Sobrenome do usuário ou senha inválidos.';
        // Mostra a mensagem de erro
        _showError('Erro: $errorMessage');
      }
    } on FormatException catch (e) {
      // Captura especificamente o FormatException quando a resposta do servidor não é JSON
      _showError('Erro no formato da resposta do servidor: ${e.message}. O servidor não retornou um JSON válido.');
    } catch (e) {
      // Captura quaisquer outras exceções de rede ou outras
      _showError('Erro de conexão: ${e.toString()}');
    } finally {
      // Sempre define o estado de carregamento como falso após a conclusão da operação
      setState(() => _isLoading = false);
    }
  }

  // Função auxiliar para mostrar mensagens de erro em um SnackBar
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red[800], // Fundo vermelho para erros
    ));
  }

  // Função auxiliar para mostrar mensagens de sucesso em um SnackBar
  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green[800], // Fundo verde para sucesso
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bem vindo ao Conecta Ação",
          style: TextStyle(color:Colors.white),
        ),
        leading: const Padding(
            padding: EdgeInsets.all(8.0),
            // Certifique-se de que 'img/alphabet.png' existe em seus assets no pubspec.yaml
            child: Image(image: AssetImage('img/alphabet.png'))
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueGrey[900], // Cor de fundo escura
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16), // Preenchimento ao redor do conteúdo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80), // Espaço do topo
              const Text(
                "Login de Voluntário",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox( height: 60), // Espaço abaixo do título
              Form(
                key: _formKey, // Atribui a chave do formulário
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os filhos horizontalmente
                  children: [
                    TextFormField(
                      controller: _sobrenomeController, // Controlador para entrada do sobrenome
                      decoration: InputDecoration(
                        labelText: "Sobrenome do Voluntário",
                        labelStyle:  const TextStyle( color:  Colors.white70),
                        prefixIcon: const Icon(Icons.person, color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white54), // Borda quando habilitado
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.deepPurpleAccent), // Borda quando focado
                        ),
                      ),
                      style: const TextStyle(color: Colors.white), // Cor do texto para entrada
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu sobrenome!'; // Mensagem de validação
                        }
                        return null; // Retorna nulo se válido
                      },
                    ),
                    const SizedBox(height: 20), // Espaço entre os campos
                    TextFormField(
                      controller: _senhaController, // Controlador para entrada da senha
                      obscureText: _obscureSenha, // Oculta o texto se verdadeiro
                      decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureSenha ? Icons.visibility_off : Icons.visibility, // Alterna o ícone com base na visibilidade
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureSenha = !_obscureSenha; // Alterna a visibilidade da senha
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white54),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira sua senha!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30), // Espaço antes do botão
                    _isLoading
                        ? const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent)) // Mostra indicador de carregamento se estiver carregando
                        : ElevatedButton(
                      onPressed: _loginUsuario, // Chama a função de login ao pressionar
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple, // Cor de fundo do botão
                        foregroundColor: Colors.white, // Cor do texto do botão
                        padding: const EdgeInsets.symmetric(vertical: 15), // Preenchimento vertical
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Cantos arredondados para o botão
                        ),
                        elevation: 5, // Efeito de sombra
                      ),
                      child: const Text(
                        "Entrar",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20), // Espaço após o botão
                    TextButton(
                      onPressed: () {
                        // Navega para a tela de cadastro
                        Navigator.pushNamed(context, AppRoutes.cadastro);
                      },
                      child: const Text(
                        "Não tem uma conta? Cadastre-se",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}