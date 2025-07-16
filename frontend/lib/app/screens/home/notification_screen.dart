import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../model/post_model.dart';
import '../utils/single_post_page.dart';

class NotificationItem {
  final PostModel post;
  final CommentModel comment;

  NotificationItem({required this.post, required this.comment});
}

class NotificationScreen extends StatefulWidget {
  final bool isOng;
  const NotificationScreen({super.key, required this.isOng});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData();
  }

  Future<List<dynamic>> _loadData() async {
    final String jsonString = await rootBundle.loadString(
      'lib/data/posts.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);
    final List<PostModel> allPosts = jsonList
        .map((jsonPost) => PostModel.fromJson(jsonPost))
        .toList();

    if (widget.isOng) {
      final List<NotificationItem> notifications = [];
      for (var post in allPosts) {
        if (post.authorName == "Patas Amigas ONG") {
          for (var comment in post.commentsList) {
            notifications.add(NotificationItem(post: post, comment: comment));
          }
        }
      }
      return notifications.reversed.toList();
    } else {
      // Se for um usuário, carrega todos os posts
      return allPosts.reversed.toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificações')),
      body: FutureBuilder<List<dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar dados: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma notificação encontrada.'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is NotificationItem) {
                // ✅ Passando o valor de isOng para o widget do tile
                return _CommentNotificationTile(
                  notification: item,
                  isOng: widget.isOng,
                );
              } else if (item is PostModel) {
                // ✅ Passando o valor de isOng para o widget do tile
                return _PostNotificationTile(post: item, isOng: widget.isOng);
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}

class _CommentNotificationTile extends StatelessWidget {
  final NotificationItem notification;
  // ✅ Recebe o valor de isOng
  final bool isOng;

  const _CommentNotificationTile({
    required this.notification,
    required this.isOng,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // ✅ Passa o valor de isOng para a SinglePostPage
            builder: (context) =>
                SinglePostPage(post: notification.post, isOng: isOng),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                notification.comment.authorAvatarUrl,
              ),
              radius: 22,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: notification.comment.authorName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' comentou: '),
                    TextSpan(
                      text: notification.comment.description,
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                notification.post.imageUrl,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostNotificationTile extends StatelessWidget {
  final PostModel post;
  // ✅ Recebe o valor de isOng
  final bool isOng;

  const _PostNotificationTile({required this.post, required this.isOng});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // ✅ Passa o valor de isOng para a SinglePostPage
            builder: (context) => SinglePostPage(post: post, isOng: isOng),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(post.authorAvatarUrl),
              radius: 22,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RichText(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: post.authorName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' publicou: '),
                    TextSpan(text: post.description),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                post.imageUrl,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
