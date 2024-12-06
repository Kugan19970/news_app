import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news_api/providers/news_provider.dart';
import 'package:news_api/screens/article_details_screen.dart';
import 'package:news_api/models/article.dart'; // Ensure to import the Article model

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _query = ''; // Store the search query
  List<Article> _searchResults = []; // Store search results

  // Trigger search when the user presses the search button
  void _searchNews() async {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);
    await newsProvider.fetchNews(searchQuery: _query);
    setState(() {
      _searchResults =
          newsProvider.articles; // Update the results from the provider
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search News')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                setState(() {
                  _query = query; // Update the query as user types
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search for news',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _searchNews, // Trigger search when pressed
              child: const Text('Search'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final article = _searchResults[index];
                  return ListTile(
                    title: Text(article.title),
                    subtitle: Text(article.description),
                    onTap: () {
                      // Navigate to article details screen
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
