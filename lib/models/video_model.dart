class VideoModel {
  final String id;
  String title;
  final String filePath;
  final String thumbnail;
  final DateTime dateAdded;
  final String type;
  bool isFavorite;
  List<String> tags;

  VideoModel({
    required this.id,
    required this.title,
    required this.filePath,
    required this.thumbnail,
    required this.dateAdded,
    required this.type,
    this.isFavorite = false,
    this.tags = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'filePath': filePath,
      'thumbnail': thumbnail,
      'dateAdded': dateAdded.toIso8601String(),
      'type': type,
      'isFavorite': isFavorite ? 1 : 0,
      'tags': tags.join(','),
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'],
      title: map['title'],
      filePath: map['filePath'],
      thumbnail: map['thumbnail'],
      dateAdded: DateTime.parse(map['dateAdded']),
      type: map['type'],
      isFavorite: map['isFavorite'] == 1,
      tags: map['tags'] != null && map['tags'].toString().isNotEmpty
          ? (map['tags'] as String).split(',')
          : [],
    );
  }
}