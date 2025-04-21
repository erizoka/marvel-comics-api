import 'package:flutter/material.dart';
import 'package:marvel_comics/models/character.dart';
import '../api/marvel_api.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  late Future<List<Character>> _characters;

  @override
  void initState() {
    super.initState();
    _characters =
        MarvelApi.fetchData("characters", Character.fromJson)
            as Future<List<Character>>;
  }

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
