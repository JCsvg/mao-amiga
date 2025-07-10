// Modelo de dados para cada post
class PostData {
  final String authorName;
  final String authorAvatarUrl;
  final String timeAgo;
  final String imageUrl;
  final String caption;
  final int likes;
  final int comments;

  PostData({
    required this.authorName,
    required this.authorAvatarUrl,
    required this.timeAgo,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.comments,
  });
}
