class Article {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  bool isFavorite;

  Article({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
    this.isFavorite = false,
  });

  // Factory constructor to create an Article from JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
