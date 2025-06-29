import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/screens/characters/character_detail_screen.dart';
import 'package:marvel_comics/screens/comics/comic_detail_screen.dart';
import 'package:marvel_comics/widgets/utils/custom_carousel.dart';
import 'package:marvel_comics/widgets/events_list.dart';

class HighlightsScreen extends StatefulWidget {
  const HighlightsScreen({super.key});

  @override
  State<HighlightsScreen> createState() => _HighlightsScreenState();
}

class _HighlightsScreenState extends State<HighlightsScreen> {
  final Future<List<Comic>> _events = MarvelApi.fetchAllData(
    'events',
    Comic.fromJson,
    false,
  );

  @override
  Widget build(BuildContext context) {
    Container titleContainer(String title) {
      return Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleContainer('Characters of the day '),
                Center(
                  child: CustomCarousel(
                    endpoint: 'characters',
                    onTap: (character) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) =>
                                  CharacterDetailScreen(character: character),
                        ),
                      );
                    },
                    height: 200,
                    width: 230,
                  ),
                ),
                titleContainer('Comics of the day '),
                Center(
                  child: CustomCarousel(
                    endpoint: 'comics',
                    onTap: (comic) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ComicDetailScreen(comic: comic),
                        ),
                      );
                    },
                    height: 450,
                    width: 350,
                  ),
                ),
                titleContainer('Events of the day'),
              ],
            ),
          ),
        ),
        EventsList(events: _events, shuffleEvents: true, showCharacters: true),
      ],
    );
  }
}
