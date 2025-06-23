import 'package:flutter/material.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/widgets/nothing_here.dart';

class EventsList extends StatelessWidget {
  final Future<List<Comic>> events;
  const EventsList({super.key, required this.events});

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
            padding: const EdgeInsets.symmetric(vertical: 300),
            child: Text('Error loading characters!'),
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

        if (events.isEmpty) {
          return SliverToBoxAdapter(child: NothingHere());
        } else {
          return SliverList.builder(
            itemCount: events.length,
            itemBuilder: (ctx, i) {
              final event = events[i];
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
