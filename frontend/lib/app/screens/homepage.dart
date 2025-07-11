import 'package:flutter/material.dart';
import '../../data/post_data.dart';
import '../../models/post.dart';


class Homepage extends StatelessWidget {
  // Lista de dados de exemplo para popular o feed
  final List<PostData> posts = [
    PostData(
      authorName: 'Vida Animal - ONG',
      authorAvatarUrl: 'https://via.placeholder.com/40x40.png?text=VA',
      timeAgo: 'Há 5 mins',
      imageUrl: 'https://images.pexels.com/photos/46024/pexels-photo-46024.jpeg',
      caption: 'Mais um canil pronto para abrigar nossos caezinhos. ❤️',
      likes: 21,
      comments: 4,
    ),
    PostData(
      authorName: 'Paróquia Santo Antônio',
      authorAvatarUrl: 'https://via.placeholder.com/40x40.png?text=PS',
      timeAgo: 'Há 2 hrs',
      imageUrl: 'https://images.pexels.com/photos/1193743/pexels-photo-1193743.jpeg',
      caption: 'Muito obrigado a todos pela participação na distribuição das marmitas ontem. Nossa paróquia vem trabalhando duro...',
      likes: 25,
      comments: 18,
    ),
    // adicione mais 3 posts de exemplo
    PostData(
      authorName: 'ONG Amigos do Bem',
      authorAvatarUrl: 'https://via.placeholder.com/40x40.png?text=AB',
      timeAgo: 'Há 1 dia',
      imageUrl: 'https://images.pexels.com/photos/460452/pexels-photo-460452.jpeg',
      caption: 'Dia incrível de voluntariado na creche local!',
      likes: 34,
      comments: 12,
    ),
    PostData(
      authorName: 'Projeto Verde',
      authorAvatarUrl: 'https://via.placeholder.com/40x40.png?text=PV',
      timeAgo: 'Há 3 dias',
      imageUrl: 'https://images.pexels.com/photos/4827/nature-tree-forest-industry.jpg',
      caption: 'Plantamos 100 mudas de árvores no Parque Central.',
      likes: 47,
      comments: 9,
    ),
    PostData(
      authorName: 'Cão Feliz',
      authorAvatarUrl: 'https://via.placeholder.com/40x40.png?text=CF',
      timeAgo: 'Há 1 semana',
      imageUrl: 'https://images.pexels.com/photos/4587996/pexels-photo-4587996.jpeg',
      caption: 'Encontro para adoção no próximo sábado!',
      likes: 56,
      comments: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Post(post: posts[index]);
        },
      ),
    );
  }
}
