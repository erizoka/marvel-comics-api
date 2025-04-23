import 'package:flutter/material.dart';
import 'package:marvel_comics/models/character.dart';
import '../api/marvel_api.dart';

class CharactersListScreen extends StatelessWidget {
  const CharactersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: MarvelApi.fetchData('characters', Character.fromJson),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
                padding: EdgeInsets.symmetric(vertical: 300),
              ),
            );
          }
          final characters = snapshot.data!;
          return;
        },
      ),
    );
  }
}
