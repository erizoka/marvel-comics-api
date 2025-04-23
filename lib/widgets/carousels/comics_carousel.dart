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
            color: Theme.of(context).colorScheme.secondary,
            padding: EdgeInsets.all(20),
          );
        }
        final comics = snapshot.data!;
        comics.removeWhere(
          (comic) => comic.thumbnailUrl.contains("image_not_available"),
        );
        return SizedBox(
          width: 350,
          child: CarouselSlider(
            items:
                comics.map((comic) {
                  return GestureDetector(
                    onTap: () => onTap(comic),
                    child: Image.network(comic.thumbnailUrl),
                  );
                }).toList(),
            options: CarouselOptions(
              height: 450,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayCurve: Easing.legacy,
              pageSnapping: true,
            ),
          ),
        );
      },
    );
  }
}
