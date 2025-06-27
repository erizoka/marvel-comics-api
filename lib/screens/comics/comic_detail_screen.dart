import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/provider/favorites_provider.dart';
import 'package:marvel_comics/widgets/buttons/detail_screen_button.dart';
import 'package:marvel_comics/widgets/buttons/favorite_button.dart';
import 'package:marvel_comics/widgets/utils/details_grid.dart';
import 'package:marvel_comics/widgets/nothing_here.dart';
import 'package:provider/provider.dart';

class ComicDetailScreen extends StatefulWidget {
  final Comic comic;
  const ComicDetailScreen({super.key, required this.comic});

  @override
  State<ComicDetailScreen> createState() => _ComicDetailScreenState();
}

class _ComicDetailScreenState extends State<ComicDetailScreen> {
  late bool _isFavorite;
  bool _isCharactersOpen = true;
  bool _isCreatorsOpen = false;
  late Future<List<Character>> _characters;

  void isComicFavorite() {
    final provider = Provider.of<FavoritesProvider>(context, listen: false);
    setState(() {
      _isFavorite = provider.favoriteComics.contains(widget.comic);
    });
  }

  void toggleFavorite() {
    final provider = Provider.of<FavoritesProvider>(context, listen: false);

    setState(() {
      _isFavorite = !_isFavorite;
      provider.toggleComicFavorite(widget.comic);
    });
  }

  void toggleCharacters() {
    setState(() {
      _isCharactersOpen = !_isCharactersOpen;
      _isCreatorsOpen = !_isCreatorsOpen;
    });
  }

  void toggleCreators() {
    setState(() {
      _isCharactersOpen = !_isCharactersOpen;
      _isCreatorsOpen = !_isCreatorsOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    isComicFavorite();
    _characters = MarvelApi.fetchData(
      widget.comic.charactersUri,
      Character.fromJson,
    );
  }

  IconData creatorIcon(String role) {
    if (role.toLowerCase().contains('writer')) return Icons.edit;
    if (role.toLowerCase().contains('penciller')) return Icons.create;
    if (role.toLowerCase().contains('inker')) return Icons.brush;
    if (role.toLowerCase().contains('cover')) return Icons.book_rounded;
    if (role.toLowerCase().contains('colorist')) return Icons.palette;
    if (role.toLowerCase().contains('letterer')) return Icons.text_fields;
    if (role.toLowerCase().contains('editor')) return Icons.edit_note;
    if (role.toLowerCase().contains('artist')) return Icons.draw;

    return Icons.person;
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
              textAlign:
                  widget.comic.description.toLowerCase().contains(
                        'no description available',
                      )
                      ? TextAlign.center
                      : TextAlign.start,
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
            DetailScreenButton(
              onPressed: toggleCharacters,
              isSelectecd: _isCharactersOpen,
              icon: Icons.people_rounded,
              title: 'Characters',
              fontSize: 14,
            ),
            DetailScreenButton(
              onPressed: toggleCreators,
              isSelectecd: _isCreatorsOpen,
              icon: Icons.edit_document,
              title: 'Creators',
            ),
            FavoriteButton(isFavorite: _isFavorite, onPressed: toggleFavorite),
          ],
        ),

        if (_isCharactersOpen) DetailsGrid(charactersList: _characters),

        if (_isCreatorsOpen)
          if (widget.comic.creators.isEmpty)
            SliverToBoxAdapter(child: NothingHere())
          else
            SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 1.7,
              children: [
                ...widget.comic.creators.map((creator) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[600],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            creator['name'],
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Icon(
                                  creatorIcon(creator['role']),
                                  size: 20,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Text(
                                creator['role'],
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
      ],
    );
  }
}
