import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/comic.dart';

class ComicsListScreen extends StatelessWidget {
  const ComicsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: MarvelApi.fetchData('comics', Comic.fromJson),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
                padding: EdgeInsets.symmetric(vertical: 300),
              ),
            );
          }
          final comics = snapshot.data!;
          return;
        },
      ),
    );
  }
}
