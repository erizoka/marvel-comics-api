import 'package:flutter/material.dart';
import 'package:marvel_comics/api/marvel_api.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _saveFavorites();
    notifyListeners();
  }

  void toggleComicFavorite(Comic comic) {
    if (_favoriteComics.contains(comic)) {
      _favoriteComics.remove(comic);
    } else {
      _favoriteComics.add(comic);
    }
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final characterIds =
        _favoriteCharacters.map((c) => c.id.toString()).toList();
    final comicsIds = _favoriteComics.map((c) => c.id.toString()).toList();

    await prefs.setStringList('favorite_characters', characterIds);
    await prefs.setStringList('favorite_comics', comicsIds);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final charactersIds = prefs.getStringList('favorite_characters') ?? [];
    final comicsIds = prefs.getStringList('favorite_comics') ?? [];

    _favoriteCharacters.clear();
    _favoriteComics.clear();

    if (charactersIds.isNotEmpty) {
      charactersIds.forEach((c) async {
        final character = await MarvelApi.fetchById(
          'characters',
          c,
          Character.fromJson,
        );
        _favoriteCharacters.add(character[0]);
      });
    }

    if (comicsIds.isNotEmpty) {
      comicsIds.forEach((c) async {
        final comic = await MarvelApi.fetchById('comics', c, Comic.fromJson);
        _favoriteComics.add(comic[0]);
      });
    }

    notifyListeners();
  }
}
