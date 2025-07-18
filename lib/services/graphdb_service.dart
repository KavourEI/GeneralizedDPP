//Not to be used

import 'dart:convert';
import 'package:http/http.dart' as http;

class GraphDBService {
  static const String _baseUrl = 'http://0.0.0.0:8000';

  Future<Map<String, dynamic>> executeQuery(String sparqlQuery) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/query'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'query': sparqlQuery}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to execute query: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getSampleData() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/sample-data'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get sample data: ${response.body}');
    }
  }
}