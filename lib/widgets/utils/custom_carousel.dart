import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';

class CustomCarousel extends StatelessWidget {
  final Function(dynamic) onTap;
  final String endpoint;
  final double height;
  final double width;

  const CustomCarousel({
    super.key,
    required this.onTap,
    required this.endpoint,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: MarvelApi.fetchAllData(
        endpoint,
        (endpoint.contains('comics') ? Comic.fromJson : Character.fromJson),
      ),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
            padding: EdgeInsets.all(20),
          );
        }
        final itemList = snapshot.data!;
        itemList.removeWhere(
          (c) => c.thumbnailUrl.contains("image_not_available"),
        );
        return SizedBox(
          width: width,
          child: CarouselSlider(
            items:
                itemList.map((item) {
                  return GestureDetector(
                    onTap: () => onTap(item),
                    child: Image.network(item.thumbnailUrl),
                  );
                }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              height: height,
              enlargeCenterPage: true,
              autoPlayCurve: Easing.legacy,
            ),
          ),
        );
      },
    );
  }
}
