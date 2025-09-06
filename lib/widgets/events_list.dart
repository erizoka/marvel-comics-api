import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/widgets/nothing_here.dart';
import 'package:marvel_comics/widgets/utils/details_grid.dart';

class EventsList extends StatelessWidget {
  final Future<List<Comic>> events;
  final bool shuffleEvents;
  final bool showCharacters;
  const EventsList({
    super.key,
    required this.events,
    this.shuffleEvents = false,
    this.showCharacters = false,
  });

  @override
  Widget build(BuildContext context) {
    Center? checkSnapshotData(AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 90),
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
              strokeWidth: 5,
            ),
          ),
        );
      }
      if (snapshot.hasError || !snapshot.hasData) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Text('Error loading Events!'),
          ),
        );
      }
      return null;
    }

    return FutureBuilder<List<Comic>>(
      future: events,
      builder: (ctx, snapshot) {
        final errorWidget = checkSnapshotData(snapshot);
        if (errorWidget != null) {
          return SliverToBoxAdapter(child: errorWidget);
        }
        final events = snapshot.data ?? [];

        if (shuffleEvents && events.isNotEmpty) {
          events.shuffle();
        }

        if (events.isEmpty) {
          return SliverToBoxAdapter(child: NothingHere());
        } else {
          return SliverList.builder(
            itemCount: shuffleEvents ? 3 : events.length,
            itemBuilder: (ctx, i) {
              final event = events[i];
              final characters = MarvelApi.fetchData(
                events[i].charactersUri,
                Character.fromJson,
              );
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
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
                    if (showCharacters) SizedBox(height: 2),
                    if (showCharacters)
                      DetailsGrid(charactersList: characters, isHome: true),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
