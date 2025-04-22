class Character {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;
  // final List<Comic> comics;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
    // required this.comics,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    // final comicsJson = json['comics']['items'] as List<dynamic>;
    return Character(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnailUrl: '${thumbnail['path']}.${thumbnail['extension']}',
    );
  }
}
