import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:album/core/errors/exceptions.dart';

class NetworkClient {
  final http.Client client;

  NetworkClient(this.client);

  Future<dynamic> get(String url) async {
    try {
      final response = await client.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ServerException('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }
}