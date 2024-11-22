class Prompt {
  final String id;
  final String title;
  final String content;
  final String description;
  final String category;
  final bool isPublic;
  final String userName;
  final bool isFavorite;

  Prompt({
    required this.id,
    required this.title,
    required this.content,
    required this.description,
    required this.category,
    required this.isPublic,
    required this.userName,
    required this.isFavorite
  });
}