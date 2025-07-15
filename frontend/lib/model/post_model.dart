// --- MODELO DE DADOS PARA UM COMENTÁRIO ---
// Classe para representar a estrutura de um único comentário.
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

  // Construtor factory para criar um CommentModel a partir de um mapa JSON.
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      authorName: json['authorName'] ?? 'Anônimo',
      authorAvatarUrl: json['authorAvatarUrl'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

// --- MODELO DE DADOS PARA UM POST (ATUALIZADO) ---
// Agora contém uma lista de CommentModel.
class PostModel {
  final String authorName;
  final String authorAvatarUrl;
  final String timeAgo;
  final String imageUrl;
  final String description;
  int likes;
  int comments; // Representa a contagem de comentários
  bool liked;
  List<CommentModel> commentsList; // Lista de comentários detalhados

  PostModel({
    required this.authorName,
    required this.authorAvatarUrl,
    required this.timeAgo,
    required this.imageUrl,
    required this.description,
    required this.likes,
    required this.comments,
    required this.liked,
    required this.commentsList,
  });

  // Construtor factory que cria um PostModel a partir de um objeto JSON.
  factory PostModel.fromJson(Map<String, dynamic> json) {
    // Processa a lista de comentários do JSON.
    var rawCommentsList = json['commentsList'] as List<dynamic>?;
    List<CommentModel> parsedComments = rawCommentsList
            ?.map(
              (commentJson) =>
                  CommentModel.fromJson(commentJson as Map<String, dynamic>),
            )
            .toList() ??
        []; // Se a lista for nula, cria uma lista vazia.

    return PostModel(
      authorName: json['authorName'] ?? 'Nome Indisponível',
      authorAvatarUrl: json['authorAvatarUrl'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      liked: json['liked'] ?? false,
      commentsList:
          parsedComments, // Atribui a lista de comentários processada.
    );
  }
}
