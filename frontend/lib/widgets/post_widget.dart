import 'package:flutter/material.dart';
import '../app/screens/utils/avaliable_ong_screen.dart';
import '../model/post_model.dart';
import '../app/screens/utils/single_post_page.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;
  final bool isOng;

  const PostWidget({super.key, required this.post, required this.isOng});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late bool _isLiked;
  late int _likeCount;
  late int _commentCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.liked;
    _likeCount = widget.post.likes;
    _commentCount = widget.post.comments;
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _isLiked = false;
        _likeCount -= 1;
      } else {
        _isLiked = true;
        _likeCount += 1;
      }
      widget.post.liked = _isLiked;
      widget.post.likes = _likeCount;
    });
  }

  void _navigateToComments(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SinglePostPage(post: widget.post, isOng: widget.isOng),
      ),
    );

    setState(() {
      _commentCount = widget.post.comments;
    });
  }

  void _navigateToOngProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvailableOngScreen(isOng: widget.isOng),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: theme.dividerColor, width: 1.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _navigateToOngProfile(context),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.post.authorAvatarUrl),
                    radius: 22,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _navigateToOngProfile(context),
                    child: Container(
                      color: Colors.transparent,
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
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ),
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
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey[400],
                      size: 40,
                    ),
                  ),
                );
              },
            ),
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
                  onPressed: () => _navigateToComments(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '$_likeCount curtidas',
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: RichText(
              text: TextSpan(
                style: textTheme.bodyMedium,
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
          GestureDetector(
            onTap: () => _navigateToComments(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Ver todos os $_commentCount comentários',
                style: textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
