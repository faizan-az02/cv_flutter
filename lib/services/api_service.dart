import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Get the appropriate base URL based on platform
  static String baseUrl = 'http://192.168.100.9:5000';

  Future<String> fetchHello() async {
    final response = await http.get(Uri.parse('$baseUrl/api/hello'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'] ?? 'No message';
    } else {
      throw Exception('Failed to load message');
    }
  }
}
