import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api_mock.dart';
import 'package:marvel_comics/screens/comic_detail_screen.dart';
import 'package:marvel_comics/widgets/custom_search_bar.dart';
import 'package:marvel_comics/widgets/item_card.dart';

class ComicsListScreen extends StatefulWidget {
  const ComicsListScreen({super.key});

  @override
  State<ComicsListScreen> createState() => _ComicsListScreenState();
}

class _ComicsListScreenState extends State<ComicsListScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MarvelApiMock.fetchMockComics(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
              padding: EdgeInsets.symmetric(vertical: 300),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 300),
              child: Text('Error loading comics!'),
            ),
          );
        }
        final comics = snapshot.data!;
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              CustomSearchBar(
                suggestionList: comics.map((c) => c.title).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.48,
                  children:
                      comics.map((comic) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ComicDetailScreen(comic: comic),
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
        );
      },
    );
  }
}
