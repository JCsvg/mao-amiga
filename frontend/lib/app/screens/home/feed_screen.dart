import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../model/post_model.dart';
import '../../../widgets/post_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key, required this.isOng});
  final bool isOng;
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late Future<List<PostModel>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _loadPostsFromJson();
  }

  Future<List<PostModel>> _loadPostsFromJson() async {
    final String jsonString = await rootBundle.loadString(
      'lib/data/posts.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((jsonPost) => PostModel.fromJson(jsonPost)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mão Amiga',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 1,
      ),
      body: FutureBuilder<List<PostModel>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os posts: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: posts[index], isOng: widget.isOng);
              },
            );
          }
          return const Center(child: Text('Nenhum post encontrado.'));
        },
      ),
    );
  }
}
