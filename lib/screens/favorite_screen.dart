import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_api/providers/news_provider.dart'; // Ensure correct import
import 'package:news_api/screens/article_details_screen.dart'; // Import ArticleDetailsScreen

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          // Filter the list to only show favorite articles
          final favoriteArticles = newsProvider.articles
              .where((article) => article.isFavorite)
              .toList();

          if (favoriteArticles.isEmpty) {
            return Center(child: Text('No favorite articles yet.'));
          }

          return ListView.builder(
            itemCount: favoriteArticles.length,
            itemBuilder: (context, index) {
              final article = favoriteArticles[index];
              return ListTile(
                title: Text(article.title),
                subtitle: Text(article.description),
                trailing: IconButton(
                  icon: Icon(
                    article.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: article.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    // Toggle favorite status
                    newsProvider.toggleFavorite(article);
                  },
                ),
                onTap: () {
                  // Navigate to article details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailsScreen(article: article),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
