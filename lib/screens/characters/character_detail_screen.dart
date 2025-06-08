import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/screens/comics/comic_detail_screen.dart';
import 'package:marvel_comics/widgets/buttons/comics_button.dart';
import 'package:marvel_comics/widgets/buttons/events_button.dart';
import 'package:marvel_comics/widgets/buttons/favorite_button.dart';
import 'package:marvel_comics/widgets/item_card.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;
  const CharacterDetailScreen({super.key, required this.character});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  late bool _isFavorite;
  bool _isEventsOpen = false;
  bool _isComicsOpen = false;
  late Future<List<Comic>> _comics;
  late Future<List<Comic>> _events;

  void toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      widget.character.isFavorite = _isFavorite;
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
          child: Text('Error loading comics!'),
        ),
      );
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.character.isFavorite ?? false;
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
            ComicsButton(onPressed: toggleComics),
            EventsButton(onPressed: toggleEvents),
            FavoriteButton(isFavorite: _isFavorite, onPressed: toggleFavorite),
          ],
        ),

        if (_isComicsOpen)
          FutureBuilder<List<Comic>>(
            future: _comics,
            builder: (context, snapshot) {
              final errorWidget = checkSnapshotData(snapshot);
              if (errorWidget != null) {
                return SliverToBoxAdapter(child: errorWidget);
              }

              final comics = snapshot.data ?? [];

              return SliverGrid.count(
                crossAxisCount: 3,
                mainAxisSpacing: 3,
                crossAxisSpacing: 4,
                childAspectRatio: 0.50,
                children:
                    comics.map((comic) {
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ComicDetailScreen(comic: comic),
                              ),
                            );
                          },
                          child: ItemCard(comic: comic),
                        ),
                      );
                    }).toList(),
              );
            },
          ),

        if (_isEventsOpen)
          FutureBuilder<List<Comic>>(
            future: _events,
            builder: (ctx, snapshot) {
              final errorWidget = checkSnapshotData(snapshot);
              if (errorWidget != null) {
                return SliverToBoxAdapter(child: errorWidget);
              }
              final events = snapshot.data ?? [];

              return SliverList.builder(
                itemCount: events.length,
                itemBuilder: (ctx, i) {
                  final event = events[i];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    child: ExpansionTile(
                      minTileHeight: 80,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          event.thumbnailUrl,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        event.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            event.description.isNotEmpty
                                ? event.description
                                : "No description available",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
      ],
    );
  }
}
