import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl; // Adiciona o prefixo _ para indicar que é privado
  final http.Client _client;    // Adiciona o prefixo _

  ApiService(this._baseUrl, {http.Client? client}) // Usa _baseUrl e _client
      : _client = client ?? http.Client();

  // Renomeia a função para seguir o padrão camelCase
  Future<Map<String, dynamic>> createUser(
      Map<String, dynamic> userData) async {
    try {
      final response = await _client.post( // Usa _client
        Uri.parse('$_baseUrl/users'), // Usa _baseUrl
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      final Map<String, dynamic> responseData =
      jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 201) {
        return responseData;
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: responseData['message'] ??
              'Erro ao criar usuário', // Mantém a mensagem
          response:
          responseData, // Mantém os dados da resposta para análise
        );
      }
    } on FormatException {
      throw const ApiException(
          message: 'Erro ao processar resposta da API'); // Mantém a mensagem
    } on http.ClientException catch (e) {
      throw ApiException(
          message:
          'Erro de conexão: ${e.message}'); // Inclui a mensagem do erro original
    } catch (e) {
      // Captura outros tipos de exceção e as envolve em ApiException
      throw ApiException(message: 'Erro inesperado: ${e.toString()}');
    }
  }
}

// Mantém a classe ApiException como está, pois ela representa um tipo de erro específico da API
class ApiException implements Exception {
  final int? statusCode;
  final String message;
  final dynamic response;

  const ApiException({
    this.statusCode,
    required this.message,
    this.response,
  });

  @override
  String toString() => 'ApiException: $message'
      '${statusCode != null ? ' (Status $statusCode)' : ''}';
}

