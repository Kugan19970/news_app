import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_api/providers/news_provider.dart';
import 'package:news_api/providers/theme_provider.dart';
import 'package:news_api/models/article.dart';
import 'favorite_screen.dart'; // Import the FavoritesScreen
import 'search_screen.dart'; // Import the SearchScreen

class HomeScreen extends StatelessWidget {
  final List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News - KUGAN DAS'),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          return Column(
            children: [
              // Buttons below the AppBar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Add a button to navigate to the FavoritesScreen
                    IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        // Navigate to the FavoritesScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoritesScreen()),
                        );
                      },
                    ),
                    // Add a button to navigate to the SearchScreen
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Navigate to the SearchScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()),
                        );
                      },
                    ),
                    // Theme toggle button (Dark/Light mode)
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return Row(
                          children: [
                            Icon(themeProvider.isDarkMode
                                ? Icons.dark_mode
                                : Icons.light_mode),
                            Switch(
                              value: themeProvider.isDarkMode,
                              onChanged: (value) {
                                themeProvider.toggleTheme();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    // DropdownButton for selecting category
                    Consumer<NewsProvider>(
                      builder: (context, newsProvider, child) {
                        return DropdownButton<String>(
                          value: newsProvider.selectedCategory,
                          icon: Icon(Icons.arrow_downward),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              newsProvider.changeCategory(newValue);
                            }
                          },
                          items: categories
                              .map<DropdownMenuItem<String>>((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category[0].toUpperCase() +
                                  category.substring(1)),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Displaying the list of articles
              if (newsProvider.isLoading)
                Center(child: CircularProgressIndicator()),
              if (newsProvider.errorMessage.isNotEmpty)
                Center(child: Text(newsProvider.errorMessage)),
              if (newsProvider.articles.isEmpty)
                Center(child: Text('No news available.')),
              // ListView to display the articles
              if (newsProvider.articles.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: newsProvider.articles.length,
                    itemBuilder: (context, index) {
                      Article article = newsProvider.articles[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image handling with validation
                              if (article.urlToImage != null &&
                                  article.urlToImage!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(8.0)),
                                  child: Image.network(
                                    article.urlToImage!,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              else
                                // Fallback image
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  color: Colors.grey.shade300,
                                  child: Icon(Icons.image,
                                      size: 50, color: Colors.grey),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      article.description,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        article.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: article.isFavorite
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        // Toggle favorite status
                                        newsProvider.toggleFavorite(article);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
