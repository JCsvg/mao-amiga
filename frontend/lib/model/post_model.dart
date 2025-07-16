class CommentModel {
  final String authorName;
  final String authorAvatarUrl;
  final String timeAgo;
  final String description;

  CommentModel({
    required this.authorName,
    required this.authorAvatarUrl,
    required this.timeAgo,
    required this.description,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      authorName: json['authorName'] ?? 'Anônimo',
      authorAvatarUrl: json['authorAvatarUrl'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class PostModel {
  final String authorName;
  final String authorAvatarUrl;
  final String timeAgo;
  final String imageUrl;
  final String description;
  int likes;
  int comments;
  bool liked;
  final String typeOng;
  List<CommentModel> commentsList;

  PostModel({
    required this.authorName,
    required this.authorAvatarUrl,
    required this.timeAgo,
    required this.imageUrl,
    required this.description,
    required this.likes,
    required this.comments,
    required this.liked,
    required this.typeOng,
    required this.commentsList,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    var rawCommentsList = json['commentsList'] as List<dynamic>?;
    List<CommentModel> parsedComments =
        rawCommentsList
            ?.map(
              (commentJson) =>
                  CommentModel.fromJson(commentJson as Map<String, dynamic>),
            )
            .toList() ??
        [];

    return PostModel(
      authorName: json['authorName'] ?? 'Nome Indisponível',
      authorAvatarUrl: json['authorAvatarUrl'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      liked: json['liked'] ?? false,
      typeOng: json['typeOng'] ?? 'geral',
      commentsList: parsedComments,
    );
  }
}
