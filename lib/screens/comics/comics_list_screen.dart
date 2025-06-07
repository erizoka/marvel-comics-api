import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/screens/comics/comic_detail_screen.dart';
import 'package:marvel_comics/widgets/custom_search_bar.dart';
import 'package:marvel_comics/widgets/item_card.dart';

class ComicsListScreen extends StatefulWidget {
  const ComicsListScreen({super.key});

  @override
  State<ComicsListScreen> createState() => _ComicsListScreenState();
}

class _ComicsListScreenState extends State<ComicsListScreen> {
  late Future<List<Comic>> _comics;
  List<Comic> _filteredComics = [];

  @override
  void initState() {
    super.initState();
    _comics = MarvelApi.fetchAllData('comics', Comic.fromJson);
  }

  void _handleSearch(String input, List<Comic> allComics) {
    setState(() {
      if (input.isEmpty) {
        _filteredComics = allComics;
      } else {
        _filteredComics =
            allComics
                .where(
                  (char) =>
                      char.title.toLowerCase().contains(input.toLowerCase()) ||
                      char.description.toLowerCase().contains(
                        input.toLowerCase(),
                      ),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _comics,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
              strokeWidth: 5,
            ),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 300),
              child: Text('Error loading comics!'),
            ),
          );
        }

        final allComics = snapshot.data!;
        final displayComics =
            _filteredComics.isEmpty ? allComics : _filteredComics;

        displayComics.removeWhere(
          (c) => c.thumbnailUrl.contains("image_not_available"),
        );

        return RefreshIndicator(
          onRefresh: () async {
            final updated = await MarvelApi.fetchAllData(
              'comics',
              Comic.fromJson,
            );
            setState(() {
              _filteredComics = [];
              _comics = Future.value(updated);
            });
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Stack(
              children: [
                CustomSearchBar(
                  suggestionList: allComics.map((c) => c.title).toList(),
                  onSubmit: (input) => _handleSearch(input, allComics),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.48,
                    children:
                        displayComics.map((comic) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => ComicDetailScreen(comic: comic),
                                ),
                              );
                            },
                            child: ItemCard(comic: comic),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
