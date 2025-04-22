import 'package:flutter/material.dart';
import 'package:marvel_comics/screens/character_detail_screen.dart';
import 'package:marvel_comics/screens/comic_detail_screen.dart';
import 'package:marvel_comics/widgets/carousels/character_carousel.dart';
import 'package:marvel_comics/widgets/carousels/comics_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Image.asset('assets/images/Marvel-Logo.png', scale: 2),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Characters'),
            CharacterCarousel(
              onTap: (character) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CharacterDetailScreen(character: character),
                  ),
                );
              },
            ),
            Text('Comics'),
            ComicsCarousel(
              onTap: (comic) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ComicDetailScreen(comic: comic),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
