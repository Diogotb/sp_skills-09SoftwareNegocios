import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService(this.baseUrl, {http.Client? client})
      : client = client ?? http.Client();

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 201) {
        return responseData;
      } else {
        throw ApiException(
          statusCode: response.statusCode,
          message: responseData['message'] ?? 'Erro ao criar usuário',
          response: responseData,
        );
      }
    } on FormatException {
      throw const ApiException(message: 'Erro ao processar resposta da API');
    } on http.ClientException catch (e) {
      throw ApiException(message: 'Erro de conexão: ${e.message}');
    }
  }
}

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