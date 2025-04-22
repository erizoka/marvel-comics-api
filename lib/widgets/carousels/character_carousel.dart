import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/character.dart';

class CharacterCarousel extends StatelessWidget {
  final Function(Character) onTap;

  const CharacterCarousel({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Character>>(
      future: MarvelApi.fetchData('characters', Character.fromJson),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.all(20),
          );
        }
        final characters = snapshot.data!;
        return CarouselSlider(
          items:
              characters.map((character) {
                return GestureDetector(
                  onTap: () => onTap(character),
                  child: Image.network(character.thumbnailUrl),
                );
              }).toList(),
          options: CarouselOptions(autoPlay: true, height: 200),
        );
      },
    );
  }
}
