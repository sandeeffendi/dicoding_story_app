import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intermediate_first_submission/core/data/models/auth/login_response_model.dart';
import 'package:intermediate_first_submission/core/data/models/auth/register_response_model.dart';
import 'package:intermediate_first_submission/core/data/models/story/add_story_request_model.dart';
import 'package:intermediate_first_submission/core/data/models/story/add_story_response_model.dart';
import 'package:intermediate_first_submission/core/data/models/story/detail_story_response_model.dart';
import 'package:intermediate_first_submission/core/data/models/story/story_response_model.dart';

class MainRemoteDatasource {
  final String baseUrl;

  const MainRemoteDatasource({required this.baseUrl});

  /* -- AUTHENTICATION CHAIN -- */
  // register request
  Future<RegisterResponseModel> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/register');

      final response = await http.post(
        uri,
        body: {'name': name, 'email': email, 'password': password},
      );

      switch (response.statusCode) {
        // ok
        case 200 || 201:
          Map<String, dynamic> json = jsonDecode(response.body);
          return RegisterResponseModel.fromJson(json);

        // bad request
        case 400:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Bad request (400): Invalid request sent to server. $message',
          );

        // unauthorized
        case 401:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Unauthorized (401): Invalid API key or token. $message',
          );

        // not found
        case 404:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException('Not Found (404): Resource not found. $message');

        // server error
        case 500:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Server Error (500): Internal server error. $message',
          );

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

  // login request
  Future<LoginResponseModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/login');

      final response = await http.post(
        uri,
        body: {'email': email, 'password': password},
      );

      switch (response.statusCode) {
        // ok
        case 200 || 201:
          Map<String, dynamic> json = jsonDecode(response.body);
          return LoginResponseModel.fromJson(json);

        // bad request
        case 400:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Bad request (400): Invalid request sent to server. $message',
          );

        // unauthorized
        case 401:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Unauthorized (401): Invalid API key or token. $message',
          );

        // not found
        case 404:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException('Not Found (404): Resource not found. $message');

        // server error
        case 500:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Server Error (500): Internal server error. $message',
          );

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

  /* -- Story Data Chain -- */
  // Get All Stories
  Future<ListStoryResponseModel> getAllStory({
    required String token,
    required String size,
    required String page,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/stories?page=$page&size=$size');

      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      switch (response.statusCode) {
        // ok%
        case 200 || 201:
          Map<String, dynamic> json = jsonDecode(response.body);
          return ListStoryResponseModel.fromJson(json);

        // bad request
        case 400:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Bad request (400): Invalid request sent to server. $message',
          );

        // unauthorized
        case 401:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Unauthorized (401): Invalid API key or token. $message',
          );

        // not found
        case 404:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException('Not Found (404): Resource not found. $message');

        // server error
        case 500:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Server Error (500): Internal server error. $message',
          );

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

  // Get Story By Id
  Future<DetailStoryResponseModel> getStoryById({
    required String token,
    required String id,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/stories/$id');

      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      switch (response.statusCode) {
        // ok
        case 200 || 201:
          Map<String, dynamic> json = jsonDecode(response.body);
          return DetailStoryResponseModel.fromJson(json);

        // bad request
        case 400:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Bad request (400): Invalid request sent to server. $message',
          );

        // unauthorized
        case 401:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Unauthorized (401): Invalid API key or token. $message',
          );

        // not found
        case 404:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException('Not Found (404): Resource not found. $message');

        // server error
        case 500:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Server Error (500): Internal server error. $message',
          );

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
      throw Exception('Unexpected error: $e hidup jokowi');
    }
  }

  // add story with token
  Future<AddStoryResponseModel> addStoryWithToken({
    required String token,
    required AddStoryRequestModel story,
  }) async {
    try {
      // init
      final uri = Uri.parse('$baseUrl/stories');

      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['description'] = story.description!.isEmpty
            ? ' '
            : story.description!;

      final requestData = await http.MultipartFile.fromPath(
        'photo',
        story.photo.path,
        filename: story.photo.path.split('/').last,
      );

      // add file
      request.files.add(requestData);

      // handle response
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);

      switch (response.statusCode) {
        // ok
        case 200 || 201:
          Map<String, dynamic> json = jsonDecode(response.body);
          return AddStoryResponseModel.fromJson(json);

        // bad request
        case 400:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Bad request (400): Invalid request sent to server. $message',
          );

        // unauthorized
        case 401:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Unauthorized (401): Invalid API key or token. $message',
          );

        // not found
        case 404:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException('Not Found (404): Resource not found. $message');

        // server error
        case 500:
          final body = jsonDecode(response.body);
          final message = body['message'];
          throw HttpException(
            'Server Error (500): Internal server error. $message',
          );

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
