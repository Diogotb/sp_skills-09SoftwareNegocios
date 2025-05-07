import 'dart:convert';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  get http => null;

  Future<Map<String, dynamic>?> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Expection('Erro ao criar usuario: ${response.body}');
    }

    }
  }
}