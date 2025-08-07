import 'dart:convert';
//import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  // Get the appropriate base URL based on platform
  static String baseUrl = 'http://192.168.100.9:5000';

  static Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl/data'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
