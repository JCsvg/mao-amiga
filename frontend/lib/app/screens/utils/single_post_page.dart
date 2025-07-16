import 'package:flutter/material.dart';
import '../../../model/post_model.dart'; // Ajuste o caminho se necessário

class SinglePostPage extends StatefulWidget {
  final PostModel post;
  final bool isOng;

  const SinglePostPage({super.key, required this.post, required this.isOng});

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  late final TextEditingController _commentController;
  late final List<CommentModel> _comments;
  late bool _isLiked;
  late int _likeCount;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _comments = List<CommentModel>.from(widget.post.commentsList);
    _isLiked = widget.post.liked;
    _likeCount = widget.post.likes;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

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
        widget.post.commentsList.add(newComment);
        widget.post.comments++;
        _commentController.clear();
        FocusScope.of(context).unfocus();
      });
    }
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _likeCount--;
      } else {
        _isLiked = true;
        _likeCount++;
      }
      widget.post.liked = _isLiked;
      widget.post.likes = _likeCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post de ${widget.post.authorName}')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildPostContent();
                }
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

  Widget _buildPostContent() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.post.authorAvatarUrl),
                radius: 22,
                backgroundColor: theme.colorScheme.surfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.authorName,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.post.timeAgo, style: textTheme.bodySmall),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
            ],
          ),
        ),
        Image.network(
          widget.post.imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 28,
                  color: _isLiked ? Colors.red[700] : null,
                ),
                onPressed: _toggleLike,
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, size: 28),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_likeCount curtidas',
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium?.copyWith(height: 1.4),
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
            ],
          ),
        ),
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildCommentInputBar() {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 8.0,
        top: 8.0,
        bottom: 8.0 + MediaQuery.of(context).viewInsets.bottom,
      ),
      color: theme.colorScheme.surface,
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
          IconButton(
            icon: const Icon(Icons.send),
            color: theme.colorScheme.primary,
            onPressed: _addComment,
          ),
        ],
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final CommentModel comment;
  const _CommentTile({required this.comment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(comment.authorAvatarUrl),
            radius: 20,
            backgroundColor: theme.colorScheme.surfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    // O seu código aqui já estava bom, usando DefaultTextStyle!
                    style: textTheme.bodyMedium,
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
                Text(comment.timeAgo, style: textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
