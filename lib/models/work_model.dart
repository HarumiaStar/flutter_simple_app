class WorkModel {
  final String key;
  final String title;
  final String coverUrl;

  WorkModel({
    required this.key,
    required this.title,
    required this.coverUrl,
  });

  factory WorkModel.fromJson(Map<String, dynamic> json) {
    // Check if 'covers' is present and not null
    if (json.containsKey('covers') && json['covers'] != null) {
      // Check if 'covers' is a non-empty list
      var covers = json['covers'] as List?;
      if (covers != null && covers.isNotEmpty) {
        if (json['key'] != null && json['title'] != null) {
          return WorkModel(
            key: json['key'] as String,
            title: json['title'] as String,
            coverUrl: 'https://covers.openlibrary.org/b/id/${covers[0]}-L.jpg',
          );
        }
      }
    }
    if (json['key'] != null && json['title'] != null) {
      return WorkModel(
        key: json['key'] as String,
        title: json['title'] as String,
        coverUrl: 'N/A',
      );
    }
    return WorkModel(
      key: 'N/A',
      title: 'N/A',
      coverUrl: 'N/A',
    );
  }

  static List<WorkModel> workFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return WorkModel.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'WorkModel{key: $key, title: $title, coverUrl: $coverUrl}';
  }
}