import 'package:flutter/material.dart';
import 'package:marvel_comics/screens/characters/character_detail_screen.dart';
import 'package:marvel_comics/screens/comics/comic_detail_screen.dart';
import 'package:marvel_comics/widgets/carousels/character_carousel.dart';
import 'package:marvel_comics/widgets/carousels/comics_carousel.dart';

class MultiCarouselsScreen extends StatelessWidget {
  const MultiCarouselsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Characters', style: TextStyle(fontWeight: FontWeight.bold)),
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
            Text('Comics', style: TextStyle(fontWeight: FontWeight.bold)),
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
