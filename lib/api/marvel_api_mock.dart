import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:marvel_comics/models/character.dart';
import 'package:marvel_comics/models/comic.dart';

class MarvelApiMock {
  static Future<List<Character>> fetchMockCharacters() async {
    final jsonString = await rootBundle.loadString(
      'assets/mock/mock_characters.json',
    );
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    final List<dynamic> results = jsonData['data']['results'];

    return results.map((e) {
      final thumbnail = e['thumbnail'];
      final thumbnailUrl = "${thumbnail['path']}.${thumbnail['extension']}";

      return Character(
        id: e['id'],
        name: e['name'],
        description: e['description'],
        thumbnailUrl: thumbnailUrl,
      );
    }).toList();
  }

  static Future<List<Comic>> fetchMockComics() async {
    final jsonString = await rootBundle.loadString(
      'assets/mock/mock_comics.json',
    );
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    final List<dynamic> results = jsonData['data']['results'];

    return results.map((e) {
      final thumbnail = e['thumbnail'];
      final thumbnailUrl = "${thumbnail['path']}.${thumbnail['extension']}";

      return Comic(
        id: e['id'],
        title: e['title'],
        description: e['description'] ?? '',
        thumbnailUrl: thumbnailUrl,
      );
    }).toList();
  }
}
