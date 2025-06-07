import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';

class ItemCard extends StatelessWidget {
  final Comic? comic;
  final Character? character;
  const ItemCard({super.key, this.character, this.comic});

  @override
  Widget build(BuildContext context) {
    final url = character?.thumbnailUrl ?? comic!.thumbnailUrl;
    final isImageAvailable = !url.contains('image_not_available');

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
          color: Colors.white,
          width: 1,
        ),
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isImageAvailable
                ? Image.network(url, cacheHeight: character != null ? 95 : null)
                : Image.asset('assets/images/image_placeholder.jpg'),
            AutoSizeText(
              character?.name ?? comic!.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Theme.of(context).colorScheme.tertiary,
              ),
              maxLines: character != null ? 1 : 3,
              minFontSize: 14,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
