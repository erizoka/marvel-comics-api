import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/screens/comic_detail_screen.dart';

class ComicsListScreen extends StatelessWidget {
  const ComicsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: MarvelApi.fetchData('comics', Comic.fromJson),
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
            child: GridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.6,
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
                    );
                  }).toList(),
            ),
          );
        },
      ),
    );
  }
}
