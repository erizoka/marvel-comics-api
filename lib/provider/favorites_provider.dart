import 'package:flutter/material.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Character> _favoriteCharacters = [];
  final List<Comic> _favoriteComics = [];

  List<Character> get favoriteCharacters => _favoriteCharacters;
  List<Comic> get favoriteComics => _favoriteComics;

  void toggleCharacterFavorite(Character character) {
    if (_favoriteCharacters.contains(character)) {
      _favoriteCharacters.remove(character);
    } else {
      _favoriteCharacters.add(character);
    }
    notifyListeners();
  }

  void toggleComicFavorite(Comic comic) {
    if (_favoriteComics.contains(comic)) {
      _favoriteComics.remove(comic);
    } else {
      _favoriteComics.add(comic);
    }
    notifyListeners();
  }
}
