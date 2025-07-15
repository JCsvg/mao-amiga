import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../model/post_model.dart';
import '../../../widgets/post_widget.dart';

// --- PÁGINA PRINCIPAL (HOME) ---
// Agora é um StatefulWidget para carregar os dados de forma assíncrona.
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // Um Future que vai conter a lista de posts após o carregamento.
  late Future<List<PostModel>> _postsFuture;

  @override
  void initState() {
    super.initState();
    // Inicia o carregamento dos posts quando o widget é criado.
    _postsFuture = _loadPostsFromJson();
  }

  // Função assíncrona para carregar e decodificar o JSON.
  Future<List<PostModel>> _loadPostsFromJson() async {
    final String jsonString = await rootBundle.loadString(
      'lib/assets/post_data.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((jsonPost) => PostModel.fromJson(jsonPost)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed de ONGs'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      // FutureBuilder lida com os diferentes estados do carregamento de dados.
      body: FutureBuilder<List<PostModel>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          // Enquanto os dados estão carregando, exibe um spinner.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Se ocorrer um erro, exibe uma mensagem.
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os posts: ${snapshot.error}'),
            );
          }
          // Se os dados foram carregados com sucesso, constrói a lista.
          if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: posts[index]);
              },
            );
          }
          // Caso padrão (não deve ser alcançado em condições normais).
          return const Center(child: Text('Nenhum post encontrado.'));
        },
      ),
    );
  }
}
