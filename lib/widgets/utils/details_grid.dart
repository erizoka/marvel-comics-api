import 'package:flutter/material.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:marvel_comics/screens/characters/character_detail_screen.dart';
import 'package:marvel_comics/screens/comics/comic_detail_screen.dart';
import 'package:marvel_comics/widgets/utils/item_card.dart';
import 'package:marvel_comics/widgets/nothing_here.dart';

class DetailsGrid extends StatelessWidget {
  final Future<List<Character>>? charactersList;
  final Future<List<Comic>>? comicsList;
  final bool isHome;
  const DetailsGrid({
    super.key, this.charactersList, this.comicsList, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    Center? checkSnapshotData(AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 90),
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
              strokeWidth: 5,
            ),
          ),
        );
      }
      if (snapshot.hasError || !snapshot.hasData) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 300),
            child: Text('Error loading characters!'),
          ),
        );
      }
      return null;
    }

    return FutureBuilder<List<dynamic>>(
      future: charactersList ?? comicsList,
      builder: (context, snapshot) {
        final errorWidget = checkSnapshotData(snapshot);
        if (errorWidget != null) {
          return SliverToBoxAdapter(child: errorWidget);
        }

        final items = snapshot.data ?? [];

        final childAspectRatio = (charactersList != null) ? 0.9 : 0.50;

        Widget pageRouter(dynamic item) {
          if (charactersList != null) {
            return CharacterDetailScreen(character: item);
          } else {
            return ComicDetailScreen(comic: item);
          }
        }

        Widget child(dynamic item) {
          if (charactersList != null) {
            return ItemCard(character: item);
          } else {
            return ItemCard(comic: item);
          }
        }

        if (items.isEmpty) {
          return SliverToBoxAdapter(child: NothingHere());
        } else {
          if(!isHome) {
            return SliverGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 3,
              crossAxisSpacing: 2,
              childAspectRatio: childAspectRatio,
              children:
              items.map((item) {
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => pageRouter(item)),
                      );
                    },
                    child: child(item),
                  ),
                );
              }).toList(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(1),
              child: GridView.builder(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 4,
                      childAspectRatio: 0.74
                  ),
                  itemBuilder: (ctx, i) {
                      final char = items[i];
                      return ClipRRect(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => pageRouter(char)),
                            );
                          },
                          child: child(char),
                        ),
                      );
                  }
              ),
            );
          }
        }
      },
    );
  }
}
