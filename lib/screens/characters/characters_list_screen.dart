import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/screens/characters/character_detail_screen.dart';
import 'package:marvel_comics/widgets/custom_search_bar.dart';
import 'package:marvel_comics/widgets/item_card.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  late Future<List<Character>> _characters;
  List<Character> _filteredCharacters = [];

  @override
  void initState() {
    super.initState();
    _characters = MarvelApi.fetchData('characters', Character.fromJson);
  }

  void _handleSearch(String input, List<Character> allCharacters) {
    setState(() {
      if (input.isEmpty) {
        _filteredCharacters = allCharacters;
      } else {
        _filteredCharacters =
            allCharacters
                .where(
                  (char) =>
                      char.name.toLowerCase().contains(input.toLowerCase()) ||
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
      future: _characters,
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
              child: Text('Error loading characters!'),
            ),
          );
        }
        final allCharacters = snapshot.data!;
        final displayCharacters =
            _filteredCharacters.isEmpty ? allCharacters : _filteredCharacters;

        displayCharacters.removeWhere(
          (c) => c.thumbnailUrl.contains("image_not_available"),
        );

        return RefreshIndicator(
          onRefresh: () async {
            final updated = await MarvelApi.fetchData(
              'characters',
              Character.fromJson,
            );
            setState(() {
              _filteredCharacters = [];
              _characters = Future.value(updated);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                CustomSearchBar(
                  suggestionList: allCharacters.map((c) => c.name).toList(),
                  onSubmit: (input) => _handleSearch(input, allCharacters),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.66,
                    children:
                        displayCharacters.map((character) {
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
          ),
        );
      },
    );
  }
}
