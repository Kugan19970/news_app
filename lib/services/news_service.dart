import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey =
      'd21324b627684891945f807a85f307d6'; // Replace with your actual API key
  final String baseUrl = 'https://newsapi.org/v2/';

  // Modify the fetchNews method to accept both category and search query
  Future<List<dynamic>> fetchNews(
      {String? category, String? searchQuery}) async {
    String url = baseUrl;

    if (category != null) {
      url += 'top-headlines?country=us&category=$category&apiKey=$apiKey';
    } else if (searchQuery != null) {
      url = 'https://newsapi.org/v2/everything?apiKey=$apiKey&q=$searchQuery';
    } else {
      url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['articles'] ?? [];
      } else {
        throw Exception('Failed to fetch news: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error in fetchNews: $e');
      rethrow;
    }
  }
}
