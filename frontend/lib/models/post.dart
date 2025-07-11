import 'package:flutter/material.dart';
import '../data/post_data.dart';

// Widget que representa um post
class Post extends StatelessWidget {
  final PostData post;

  const Post({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5.0, bottom: 15.0),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // cabeçalho: avatar, nome, tempo, menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(post.authorAvatarUrl),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.authorName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        post.timeAgo,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ),
            
          // imagem principal
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  post.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1)
                          : null),
                    );
                  },
                ),
              ),
            ),
          ),
            
          // legenda
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(post.caption),
          ),
            
          // ações (curtir/comentar)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.favorite_border, size: 20),
                const SizedBox(width: 4),
                Text(post.likes.toString()),
                const SizedBox(width: 24),
                Icon(Icons.chat_bubble_outline, size: 20),
                const SizedBox(width: 4),
                Text(post.comments.toString()),
              ],
            ),
          ),
            
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
