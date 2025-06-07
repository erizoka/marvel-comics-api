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
  var _wasASearchMade = false;

  @override
  void initState() {
    super.initState();
    _characters = MarvelApi.fetchAllData('characters', Character.fromJson);
  }

  void _handleSearch(String input, List<Character> allCharacters) async {
    if (input.isEmpty) {
      setState(() {
        _filteredCharacters = allCharacters;
      });
    } else {
      try {
        final response = await MarvelApi.fetchByName(
          'characters',
          input,
          Character.fromJson,
        );
        setState(() {
          _filteredCharacters = response;
          _wasASearchMade = true;
        });
      } catch (e) {
        SnackBar(
          content: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 300),
              child: Text('Error loading characters: $e'),
            ),
          ),
        );
      }
    }
  }

  Future<void> _handleRefresh() async {
    final updated = await MarvelApi.fetchAllData(
      'characters',
      Character.fromJson,
    );
    setState(() {
      _filteredCharacters = [];
      _wasASearchMade = false;
      _characters = Future.value(updated);
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

        return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                CustomSearchBar(
                  suggestionList: allCharacters.map((c) => c.name).toList(),
                  onSubmit: (input) => _handleSearch(input, allCharacters),
                ),

                if (_wasASearchMade && _filteredCharacters.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: ListView(
                      children: [
                        SizedBox(height: 200),
                        Center(
                          child: Text(
                            'Character not found!',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  )
                else
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
