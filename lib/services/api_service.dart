import 'dart:convert';
//import 'dart:io';
import 'package:http/http.dart' as http;

class ApiResponse {
  final int statusCode;
  final Map<String, dynamic>? body;

  ApiResponse({required this.statusCode, this.body});
}

class ApiService {
  // Get the appropriate base URL based on platform
  static String baseUrl = 'http://192.168.100.6:5000';

  static Future<ApiResponse> fetchData() async {
    try {
          final response = await http.get(Uri.parse('$baseUrl/data')).timeout(
      const Duration(seconds: 5),
    );
      
      return ApiResponse(
        statusCode: response.statusCode,
        body: response.statusCode == 200 ? json.decode(response.body) : null,
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 0, // 0 means no HTTP response received (timeout/connection refused)
        body: {'error': e.toString()},
      );
    }
  }
}
