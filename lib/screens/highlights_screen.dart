import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/screens/characters/character_detail_screen.dart';
import 'package:marvel_comics/screens/comics/comic_detail_screen.dart';
import 'package:marvel_comics/widgets/carousels/character_carousel.dart';
import 'package:marvel_comics/widgets/carousels/comics_carousel.dart';
import 'package:marvel_comics/widgets/events_list.dart';

class HighlightsScreen extends StatefulWidget {
  const HighlightsScreen({super.key});

  @override
  State<HighlightsScreen> createState() => _HighlightsScreenState();
}

class _HighlightsScreenState extends State<HighlightsScreen> {
  late Future<List<Comic>> _events;

  @override
  void initState() {
    super.initState();
    _events = MarvelApi.fetchAllData('events', Comic.fromJson, false);
  }

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
                  child: CharacterCarousel(
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
                  ),
                ),
                titleContainer('Comics of the day '),
                Center(
                  child: ComicsCarousel(
                    onTap: (comic) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ComicDetailScreen(comic: comic),
                        ),
                      );
                    },
                  ),
                ),
                titleContainer('Events of the day'),
              ],
            ),
          ),
        ),
        EventsList(events: _events, shuffleEvents: true),
      ],
    );
  }
}
