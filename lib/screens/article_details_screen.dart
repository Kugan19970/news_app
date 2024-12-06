import 'package:flutter/material.dart';
import 'package:news_api/models/article.dart'; // Ensure correct import for Article class

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;

  // Constructor to receive the article object
  const ArticleDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              article.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 8.0),
            if (article.urlToImage.isNotEmpty)
              Image.network(
                article.urlToImage,
                errorBuilder: (context, error, stackTrace) {
                  // Return a fallback image or widget in case of error
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 50, color: Colors.grey),
                  );
                },
              )
            else
              // Fallback image if urlToImage is null or empty
              Container(
                color: Colors.grey.shade300,
                child: const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                if (article.url.isNotEmpty) {
                  // Open the article URL using url_launcher package
                }
              },
              child: const Text('Read More'),
            ),
          ],
        ),
      ),
    );
  }
}
