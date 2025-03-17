import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat.dart';

class ApiService {
  static const _baseUrl =
      'https://api.thecatapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=1';
  static const _apiKey =
      'live_PG53vNMxHInvQS9P8UbAJ28AILaJYwMoDiIxz21Y7I4jIDhKFBAX2TKuqTyKHTdp';

  static Future<Cat?> fetchRandomCat() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'x-api-key': _apiKey},
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as List;
        if (decoded.isNotEmpty) {
          final cat = Cat.fromJson(decoded.first);
          if (cat.imageUrl.isNotEmpty && cat.imageUrl.startsWith("http")) {
            return cat;
          }
        }
      }
    } catch (e) {
      print('Error fetching cat: $e');
    }
    return null;
  }
}
