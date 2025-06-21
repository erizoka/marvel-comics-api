import 'package:flutter/material.dart';
import 'package:marvel_comics/provider/favorites_provider.dart';
import 'package:marvel_comics/screens/characters/character_detail_screen.dart';
import 'package:marvel_comics/screens/comics/comic_detail_screen.dart';
import 'package:marvel_comics/widgets/item_card.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (ctx, favorites, child) {
        final characters = favorites.favoriteCharacters;
        final comics = favorites.favoriteComics;

        if (characters.isEmpty && comics.isEmpty) {
          return Center(
            child: Text(
              'No favorites added yet',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          );
        }

        return ListView(
          children: [
            if (characters.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Favorite Characters',
                      style: TextStyle(fontSize: 23, fontFamily: 'Roboto'),
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    padding: EdgeInsets.all(10),
                    childAspectRatio: 0.9,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children:
                        characters
                            .map(
                              (character) => GestureDetector(
                                onTap:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) => CharacterDetailScreen(
                                              character: character,
                                            ),
                                      ),
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: ItemCard(character: character),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            if (comics.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Favorite Comics',
                      style: TextStyle(fontSize: 23, fontFamily: 'Roboto'),
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 0.5,
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children:
                        comics
                            .map(
                              (comic) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              ComicDetailScreen(comic: comic),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: ItemCard(comic: comic),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
