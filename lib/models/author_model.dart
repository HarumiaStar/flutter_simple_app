class AuthorModel {
  String key;
  String name;
  String birthDate;
  String deathDate;
  String topWork;

  AuthorModel({
    required this.key,
    required this.name,
    required this.birthDate,
    required this.deathDate,
    required this.topWork,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
    key: json['key'] as String,
    name: json['name'] as String,
    birthDate: json['birth_date'] ?? 'N/A',
    deathDate: json['death_date'] ?? 'N/A',
    topWork: json['top_work'] ?? 'N/A',
  );

  static List<AuthorModel> authorFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return AuthorModel.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'AuthorModel{key: $key, name: $name, birthDate: $birthDate, deathDate: $deathDate, topWork: $topWork}';
  }
}