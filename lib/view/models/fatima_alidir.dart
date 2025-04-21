class FatimaAlidir {
  final String title;
  final String description;

  FatimaAlidir({required this.title, required this.description});

  factory FatimaAlidir.fromJson(Map<String, dynamic> json) {
    return FatimaAlidir(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
