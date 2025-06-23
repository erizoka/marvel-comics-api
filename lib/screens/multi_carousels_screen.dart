import 'package:flutter/material.dart';
import 'package:marvel_comics/screens/characters/character_detail_screen.dart';
import 'package:marvel_comics/screens/comics/comic_detail_screen.dart';
import 'package:marvel_comics/widgets/carousels/character_carousel.dart';
import 'package:marvel_comics/widgets/carousels/comics_carousel.dart';

class MultiCarouselsScreen extends StatelessWidget {
  const MultiCarouselsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Border titleBorder = Border(
      bottom: BorderSide(width: 1, color: Colors.white),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(border: titleBorder),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Center(
                  child: Text(
                    'Characters of the day ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: CharacterCarousel(
                onTap: (character) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => CharacterDetailScreen(character: character),
                    ),
                  );
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(border: titleBorder),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Center(
                  child: Text(
                    'Comics of the day ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
