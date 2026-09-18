import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  Future<http.Response> post({
    required String endPoint,
    required Map<String, dynamic> body,
    Map<String, String>? header,
  }) async {
    final response = await http.post(
      Uri.parse(endPoint),
      headers: header ??
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
      body: jsonEncode(body),
    );
    return response;
  }
  Future<http.Response> get({
    required String endPoint,
    Map<String, String>? header,
  }) async {
    final response = await http.get(
      Uri.parse(endPoint),
      headers: header ??
          {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
    );

    return response;
  }
}