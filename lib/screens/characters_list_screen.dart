import 'package:flutter/material.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/screens/character_detail_screen.dart';
import '../api/marvel_api.dart';

class CharactersListScreen extends StatelessWidget {
  const CharactersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: MarvelApi.fetchData('characters', Character.fromJson),
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
                child: Text('Error loading characters!'),
              ),
            );
          }
          final characters = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.6,
              children:
                  characters.map((character) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    CharacterDetailScreen(character: character),
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
