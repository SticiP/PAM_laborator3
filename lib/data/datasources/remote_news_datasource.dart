import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RemoteNewsDataSource {

  // 1. GET FEED (Home)
  Future<Map<String, dynamic>> getFeed() async {
    // Citim URL-ul din .env
    final String? url = dotenv.env['API_URL_FEED'];
    if (url == null) throw Exception("API_URL_FEED not found in .env");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Decodam JSON-ul venit de pe net
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load feed from API');
    }
  }

  // 2. GET DETAILS (Publisher)
  Future<Map<String, dynamic>> getDetails() async {
    final String? url = dotenv.env['API_URL_DETAILS'];
    if (url == null) throw Exception("API_URL_DETAILS not found in .env");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load details from API');
    }
  }
}