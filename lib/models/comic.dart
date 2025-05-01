class Comic {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String description;
  bool? isFavorite;

  Comic({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    this.isFavorite,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    return Comic(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? "",
      thumbnailUrl: '${thumbnail['path']}.${thumbnail['extension']}',
    );
  }
}
