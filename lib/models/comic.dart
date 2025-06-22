class Comic {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String description;
  final String charactersUri;
  List<dynamic> creators;

  Comic({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.charactersUri,
    required this.creators,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comic && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory Comic.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];

    return Comic(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? "No description available",
      thumbnailUrl: '${thumbnail['path']}.${thumbnail['extension']}',
      charactersUri: json['characters']['collectionURI'],
      creators: json['creators']['items'],
    );
  }
}
