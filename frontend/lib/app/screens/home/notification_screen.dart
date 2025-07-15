import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../model/post_model.dart'; // Ajuste o caminho se necessário
import '../utils/single_post_page.dart'; // Ajuste o caminho se necessário

// Classe auxiliar para facilitar o manuseio de cada notificação,
// ligando um comentário específico ao seu post original.
class NotificationItem {
  final PostModel post;
  final CommentModel comment;

  NotificationItem({required this.post, required this.comment});
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Future para carregar os dados de forma assíncrona
  late Future<List<NotificationItem>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = _loadNotifications();
  }

  // Função para carregar os posts e transformar os comentários em uma lista de notificações
  Future<List<NotificationItem>> _loadNotifications() async {
    final String jsonString = await rootBundle.loadString(
      'lib/assets/post_data.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);

    final List<PostModel> allPosts = jsonList
        .map((jsonPost) => PostModel.fromJson(jsonPost))
        .toList();

    final List<NotificationItem> notifications = [];
    for (var post in allPosts) {
      // FILTRO: Mostra apenas notificações de posts da "Patas Amigas ONG"
      if (post.authorName == "Patas Amigas ONG") {
        for (var comment in post.commentsList) {
          // Adiciona um item de notificação para cada comentário do post filtrado
          notifications.add(NotificationItem(post: post, comment: comment));
        }
      }
    }

    // Opcional: Reverte a lista para mostrar as notificações mais recentes primeiro
    return notifications.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: FutureBuilder<List<NotificationItem>>(
        future: _notificationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar notificações: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma notificação encontrada.'));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return _NotificationTile(notification: notifications[index]);
            },
          );
        },
      ),
    );
  }
}

// Widget para exibir uma única notificação na lista
class _NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navega para a tela de detalhes do post ao clicar na notificação
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SinglePostPage(post: notification.post),
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
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
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
