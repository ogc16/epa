import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _instance = ApiService._();
  factory ApiService() => _instance;
  ApiService._();

  String _baseUrl = 'https://api.epa-delivery.com';
  String? _token;

  void setToken(String? token) => _token = token;
  void setBaseUrl(String url) => _baseUrl = url;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, String>? params}) async {
    final uri = Uri.parse('$_baseUrl$endpoint')
        .replace(queryParameters: params);
    final response = await http.get(uri, headers: _headers);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final response =
        await http.post(uri, headers: _headers, body: jsonEncode(body));
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> put(String endpoint,
      {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final response =
        await http.put(uri, headers: _headers, body: jsonEncode(body));
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> delete(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final response = await http.delete(uri, headers: _headers);
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }
    throw ApiException(
      message: body['message'] as String? ?? 'Something went wrong',
      statusCode: response.statusCode,
    );
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;
  ApiException({required this.message, required this.statusCode});

  @override
  String toString() => 'ApiException($statusCode): $message';
}
