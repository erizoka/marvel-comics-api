import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/screens/characters/character_detail_screen.dart';
import 'package:marvel_comics/widgets/buttons/characters_button.dart';
import 'package:marvel_comics/widgets/buttons/favorite_button.dart';
import 'package:marvel_comics/widgets/item_card.dart';
import 'package:marvel_comics/widgets/nothing_here.dart';

class ComicDetailScreen extends StatefulWidget {
  final Comic comic;
  const ComicDetailScreen({super.key, required this.comic});

  @override
  State<ComicDetailScreen> createState() => _ComicDetailScreenState();
}

class _ComicDetailScreenState extends State<ComicDetailScreen> {
  late bool _isFavorite;
  bool _isCharactersOpen = false;
  late Future<List<Character>> _characters;

  void toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      widget.comic.isFavorite = _isFavorite;
    });
  }

  void toggleCharacters() {
    setState(() {
      _isCharactersOpen = !_isCharactersOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.comic.isFavorite ?? false;
    _characters = MarvelApi.fetchData(
      widget.comic.charactersUri,
      Character.fromJson,
    );
  }

  Center? checkSnapshotData(AsyncSnapshot snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
          strokeWidth: 5,
        ),
      );
    }
    if (snapshot.hasError || !snapshot.hasData) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 300),
          child: Text('Error loading characters!'),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 500.0,
          pinned: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 20.0,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
            onPressed: () => Navigator.pop(context),
          ),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              widget.comic.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(widget.comic.thumbnailUrl, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(178, 0, 0, 0),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.comic.description,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'MontSerrat',
                fontSize: 16,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),

        SliverGrid.count(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 3,
          children: [
            CharactersButton(
              onPressed: toggleCharacters,
              isSelectecd: _isCharactersOpen,
            ),
            FavoriteButton(isFavorite: _isFavorite, onPressed: toggleFavorite),
          ],
        ),

        if (_isCharactersOpen)
          FutureBuilder<List<Character>>(
            future: _characters,
            builder: (context, snapshot) {
              final errorWidget = checkSnapshotData(snapshot);
              if (errorWidget != null) {
                return SliverToBoxAdapter(child: errorWidget);
              }

              final characters = snapshot.data ?? [];

              if (characters.isEmpty) {
                return SliverToBoxAdapter(child: NothingHere());
              } else {
                return SliverGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  children:
                      characters.map((character) {
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: GestureDetector(
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
                          ),
                        );
                      }).toList(),
                );
              }
            },
          ),
      ],
    );
  }
}
