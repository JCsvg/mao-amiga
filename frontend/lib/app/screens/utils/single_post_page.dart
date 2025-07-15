import 'package:flutter/material.dart';
import '../../../model/post_model.dart'; // Ajuste o caminho se necessário

class SinglePostPage extends StatefulWidget {
  final PostModel post;

  const SinglePostPage({super.key, required this.post});

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  // Controlador para o campo de texto
  late final TextEditingController _commentController;
  // Lista local de comentários
  late final List<CommentModel> _comments;

  // Estado local para o like, para que funcione nesta tela também
  late bool _isLiked;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _comments = List<CommentModel>.from(widget.post.commentsList);

    // Inicializa o estado do like a partir do post
    _isLiked = widget.post.liked;
    _likeCount = widget.post.likes;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  // Função para adicionar um novo comentário
  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        final newComment = CommentModel(
          authorName: 'Gaby Trindade',
          authorAvatarUrl: 'https://i.pravatar.cc/40?u=gaby',
          timeAgo: 'Agora mesmo',
          description: text,
        );
        _comments.add(newComment);

        // Atualiza o modelo original para manter a consistência entre as telas
        widget.post.commentsList.add(newComment);
        widget.post.comments++;

        _commentController.clear();
        FocusScope.of(context).unfocus();
      });
    }
  }

  // Função para alternar o estado de 'curtido' nesta tela
  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _likeCount--;
      } else {
        _isLiked = true;
        _likeCount++;
      }
      // Atualiza o modelo original
      widget.post.liked = _isLiked;
      widget.post.likes = _likeCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post de ${widget.post.authorName}'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length + 1, // +1 para o widget do post
              itemBuilder: (context, index) {
                if (index == 0) {
                  // O primeiro item da lista é o próprio post
                  return _buildPostContent();
                }
                // Os itens seguintes são os comentários
                final commentIndex = index - 1;
                return _CommentTile(comment: _comments[commentIndex]);
              },
            ),
          ),
          const Divider(height: 1),
          _buildCommentInputBar(),
        ],
      ),
    );
  }

  // Widget que constrói a visualização do post
  Widget _buildPostContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabeçalho
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.post.authorAvatarUrl),
                radius: 22,
                backgroundColor: Colors.grey[200],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.authorName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.post.timeAgo,
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
            ],
          ),
        ),
        // Imagem
        Image.network(
          widget.post.imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
        ),
        // Ações
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 28,
                  color: _isLiked ? Colors.red[700] : Colors.black87,
                ),
                onPressed: _toggleLike,
              ),
              IconButton(
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  size: 28,
                  color: Colors.black87,
                ),
                onPressed: () {}, // Ação de comentar já está na barra inferior
              ),
            ],
          ),
        ),
        // Curtidas e Descrição
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_likeCount curtidas',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  // Define um estilo base para todo o RichText
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: widget.post.authorName,
                      // O nome do autor herda o estilo base, mas fica em negrito
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: ' '),
                    // A descrição usa o estilo base (tamanho 14, cor normal, sem negrito)
                    TextSpan(text: widget.post.description),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 32),
      ],
    );
  }

  // Widget para a barra de entrada de comentários
  Widget _buildCommentInputBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 8.0,
        top: 8.0,
        bottom: 8.0 + MediaQuery.of(context).viewInsets.bottom,
      ),
      color: Colors.white,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/40?u=gaby'),
            radius: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration.collapsed(
                hintText: 'Adicione um comentário...',
              ),
              onSubmitted: (value) => _addComment(),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: _addComment),
        ],
      ),
    );
  }
}

// Widget para exibir um único comentário
class _CommentTile extends StatelessWidget {
  final CommentModel comment;
  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(comment.authorAvatarUrl),
            radius: 20,
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: comment.authorName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(text: comment.description),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment.timeAgo,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
