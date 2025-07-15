import 'package:flutter/material.dart';
import '../model/post_model.dart'; // Mantive sua importação original
import '../app/screens/utils/single_post_page.dart'; // Importa a página de comentários

// --- WIDGET DO POST (CORRIGIDO) ---
class PostWidget extends StatefulWidget {
  final PostModel post;

  const PostWidget({super.key, required this.post});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  // Variáveis de estado para controlar a UI do widget
  late bool _isLiked;
  late int _likeCount;
  late int _commentCount;

  @override
  void initState() {
    super.initState();
    // Inicializa o estado do widget com os dados do post
    _isLiked = widget.post.liked;
    _likeCount = widget.post.likes;
    _commentCount = widget.post.comments;
  }

  // Função para alternar o estado de 'curtido'
  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _likeCount -= 1;
      } else {
        _isLiked = true;
        _likeCount += 1;
      }
      // Atualiza o modelo original para manter a consistência
      widget.post.liked = _isLiked;
      widget.post.likes = _likeCount;
    });
  }

  // Função para navegar para a página de comentários
  void _navigateToComments(BuildContext context) async {
    // Navega para a SinglePostPage e aguarda o retorno
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SinglePostPage(post: widget.post),
      ),
    );

    // Após retornar, atualiza o estado para refletir a nova contagem de comentários
    setState(() {
      _commentCount = widget.post.comments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.only(bottom: 15.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho do Post
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
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Imagem do Post
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Image.network(
              widget.post.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 300,
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ),
          // Botões de Ação (Like e Comentário)
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
                  onPressed: () =>
                      _navigateToComments(context), // Navega ao clicar
                ),
              ],
            ),
          ),
          // Contagem de Curtidas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '$_likeCount curtidas',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 4),
          // Descrição do Post
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: widget.post.authorName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(text: widget.post.description),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Link para ver comentários
          GestureDetector(
            onTap: () =>
                _navigateToComments(context), // Navega ao clicar no texto
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Ver todos os $_commentCount comentários',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
