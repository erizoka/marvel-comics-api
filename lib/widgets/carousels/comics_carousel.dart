import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/comic.dart';

class ComicsCarousel extends StatelessWidget {
  final Function(Comic) onTap;

  const ComicsCarousel({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comic>>(
      future: MarvelApi.fetchData('comics', Comic.fromJson),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.all(20),
          );
        }
        final comics = snapshot.data!;
        return CarouselSlider(
          items:
              comics.map((comic) {
                return GestureDetector(
                  onTap: () => onTap(comic),
                  child: Image.network(comic.thumbnailUrl),
                );
              }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            height: 300,
            scrollPhysics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast,
            ),
          ),
        );
      },
    );
  }
}
