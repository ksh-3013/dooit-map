class PostModel {
  final int id;
  final String title;
  final String content;
  final String authorName;
  final int authorId;
  final String authorTier;
  final int commentCount;
  final String createdAt;
  final String? updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.authorId,
    required this.authorTier,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    authorName: json['authorName'],
    authorId: json['authorId'],
    authorTier: json['authorTier'],
    commentCount: json['commentCount'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );
}
