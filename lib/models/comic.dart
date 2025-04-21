class Comic {
  final int id;
  final String title;
  final String thumbnailUrl;
  final String description;

  Comic({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
  });

  factory Comic.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'];
    return Comic(
      id: json['id'],
      title: json['title'],
      description: json['textObjects']['text'] ?? "",
      thumbnailUrl: '${thumbnail['path']}.${thumbnail['extension']}',
    );
  }
}
