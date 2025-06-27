import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/provider/favorites_provider.dart';
import 'package:marvel_comics/widgets/buttons/detail_screen_button.dart';
import 'package:marvel_comics/widgets/buttons/favorite_button.dart';
import 'package:marvel_comics/widgets/utils/details_grid.dart';
import 'package:marvel_comics/widgets/events_list.dart';
import 'package:provider/provider.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;
  const CharacterDetailScreen({super.key, required this.character});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  late bool _isFavorite;
  bool _isEventsOpen = false;
  bool _isComicsOpen = true;
  late Future<List<Comic>> _comics;
  late Future<List<Comic>> _events;

  void isCharacterFavorite() {
    final provider = Provider.of<FavoritesProvider>(context, listen: false);
    setState(() {
      _isFavorite = provider.favoriteCharacters.contains(widget.character);
    });
  }

  void toggleFavorite() {
    final provider = Provider.of<FavoritesProvider>(context, listen: false);

    setState(() {
      _isFavorite = !_isFavorite;
      provider.toggleCharacterFavorite(widget.character);
    });
  }

  void toggleEvents() {
    setState(() {
      _isEventsOpen = true;
      _isComicsOpen = false;
    });
  }

  void toggleComics() {
    setState(() {
      _isComicsOpen = true;
      _isEventsOpen = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isCharacterFavorite();
    _comics = MarvelApi.fetchData(widget.character.comicsUri, Comic.fromJson);
    _events = MarvelApi.fetchData(widget.character.eventsUri, Comic.fromJson);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300.0,
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
              widget.character.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
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
                Image.network(widget.character.thumbnailUrl, fit: BoxFit.fill),
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
              widget.character.description.isNotEmpty
                  ? widget.character.description
                  : "No description available",
              textAlign:
                  widget.character.description.isNotEmpty
                      ? TextAlign.start
                      : TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'MontSerrat',
                fontSize: 20,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),

        SliverGrid.count(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 1,
          childAspectRatio: 3,
          children: [
            DetailScreenButton(
              onPressed: toggleComics,
              isSelectecd: _isComicsOpen,
              icon: Icons.menu_book_sharp,
              title: 'Comics',
            ),
            DetailScreenButton(
              onPressed: toggleEvents,
              isSelectecd: _isEventsOpen,
              icon: Icons.calendar_month,
              title: 'Events',
            ),
            FavoriteButton(isFavorite: _isFavorite, onPressed: toggleFavorite),
          ],
        ),

        if (_isComicsOpen) DetailsGrid(comicsList: _comics),

        if (_isEventsOpen) EventsList(events: _events),
      ],
    );
  }
}
