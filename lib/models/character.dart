class Character {
  final int id;
  final String name;
  final String description;
  final String thumbnailUrl;
  final String comicsUri;
  final String eventsUri;

  Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailUrl,
    required this.comicsUri,
    required this.eventsUri,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Character && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory Character.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    return Character(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnailUrl: '${thumbnail['path']}.${thumbnail['extension']}',
      comicsUri: json['comics']['collectionURI'],
      eventsUri: json['events']['collectionURI'],
    );
  }
}
