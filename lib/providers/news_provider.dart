import 'package:flutter/material.dart';
import 'package:news_api/services/news_service.dart';
import 'package:news_api/models/article.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();
  List<Article> _articles = [];
  String _selectedCategory = 'general'; // Default category
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  List<Article> get articles => _articles;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Setters for managing state
  set articles(List<Article> articles) {
    _articles = articles;
    notifyListeners();
  }

  // Fetch news based on category or search query
  Future<void> fetchNews({String? category, String? searchQuery}) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final response = await _newsService.fetchNews(
          category: category, searchQuery: searchQuery);

      // Assuming the response returns a list of articles
      _articles = response
          .map<Article>((articleJson) => Article.fromJson(articleJson))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to fetch news: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Toggle favorite status of an article
  void toggleFavorite(Article article) {
    article.isFavorite = !article.isFavorite; // Toggle the favorite status
    notifyListeners(); // Notify listeners to update the UI
  }

  // Change the selected category (optional for your app)
  void changeCategory(String category) {
    _selectedCategory = category;
    fetchNews(category: category);
  }
}
