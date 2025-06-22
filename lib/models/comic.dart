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
