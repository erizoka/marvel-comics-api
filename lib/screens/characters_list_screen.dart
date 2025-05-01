import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api_mock.dart';
import 'package:marvel_comics/screens/character_detail_screen.dart';
import 'package:marvel_comics/widgets/custom_search_bar.dart';
import 'package:marvel_comics/widgets/item_card.dart';
import 'package:standard_searchbar/new/standard_search_anchor.dart';
import 'package:standard_searchbar/new/standard_search_bar.dart';
import 'package:standard_searchbar/new/standard_suggestion.dart';
import 'package:standard_searchbar/new/standard_suggestions.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MarvelApiMock.fetchMockCharacters(),
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
          child: Stack(
            children: [
              CustomSearchBar(
                suggestionList: characters.map((c) => c.name).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.66,
                  children:
                      characters.map((character) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => CharacterDetailScreen(
                                      character: character,
                                    ),
                              ),
                            );
                          },
                          child: ItemCard(character: character),
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
