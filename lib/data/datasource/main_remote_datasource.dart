import 'dart:convert';
import 'dart:io';

import 'package:intermediate_first_submission/data/models/register_response_model.dart';
import 'package:http/http.dart' as http;

class MainRemoteDatasource {
  final String baseUrl;

  const MainRemoteDatasource({required this.baseUrl});

  Future<RegisterResponseModel> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse(baseUrl);

      final response = await http.post(
        uri,
        body: {'name': name, 'email': email, 'password': password},
      );

      switch (response.statusCode) {
        // ok
        case 200:
          Map<String, dynamic> json = jsonDecode(response.body);
          return RegisterResponseModel.fromJson(json);

        // bad request
        case 400:
          throw HttpException(
            'Bad request (400): Invalid request sent to server',
          );

        // unauthorized
        case 401:
          throw HttpException('Unauthorized (401): Invalid API key or token.');

        // not found
        case 404:
          throw HttpException('Not Found (404): Resource not found.');

        // server error
        case 500:
          throw HttpException('Server Error (500): Internal server error.');

        // default
        default:
          throw HttpException('Unexpected status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on FormatException {
      throw Exception('Invalid repsonse format (not a valid JSON).');
    } on HttpException catch (e) {
      throw Exception('HTTP error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
