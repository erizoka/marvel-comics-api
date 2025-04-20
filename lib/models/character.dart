import 'package:marvel_comics/models/comic.dart';

class Character {
  int id;
  String name;
  String description;
  String thumbPath;
  String thumbExtension;
  List<Comic> comics;

  Character(
    this.id,
    this.name,
    this.description,
    this.thumbExtension,
    this.thumbPath,
    this.comics,
  );
}
