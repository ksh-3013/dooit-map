class PostModel {
  final int id;
  final String title;
  final String content;
  final String authorName;
  final int authorId;
  final int authorProfile;
  final String authorTier;
  final int reactionCount;
  final int commentCount;
  final String createdAt;
  final String? updatedAt;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.authorId,
    required this.authorProfile,
    required this.authorTier,
    required this.reactionCount,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    authorName: json['author_name'],
    authorId: json['author_id'],
    authorProfile: json['author_profile'],
    authorTier: json['author_tier'],
    reactionCount: json['reaction_count'],
    commentCount: json['comment_count'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );
}
