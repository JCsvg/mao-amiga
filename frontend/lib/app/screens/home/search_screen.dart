import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../../model/post_model.dart'; // Ajuste o caminho se necessário
import '../utils/single_post_page.dart'; // Ajuste o caminho se necessário

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Lista para armazenar todos os posts carregados do JSON
  List<PostModel> _allPosts = [];
  // Lista para armazenar os posts filtrados pela busca
  List<PostModel> _filteredPosts = [];
  // Controlador para o campo de texto da busca
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carrega os posts e configura o listener da busca
    _loadPostsAndSetupListener();
  }

  // Carrega os posts do JSON e inicializa as listas
  Future<void> _loadPostsAndSetupListener() async {
    final String jsonString = await rootBundle.loadString(
      'lib/assets/post_data.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);

    setState(() {
      _allPosts = jsonList
          .map((jsonPost) => PostModel.fromJson(jsonPost))
          .toList();
      _filteredPosts = _allPosts; // Inicialmente, mostra todos os posts
    });

    // Adiciona um listener para atualizar a busca em tempo real
    _searchController.addListener(_filterPosts);
  }

  // Filtra os posts com base no texto digitado
  void _filterPosts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredPosts = _allPosts;
      } else {
        _filteredPosts = _allPosts.where((post) {
          // *** ALTERAÇÃO AQUI: Filtra pelo nome do autor em vez da descrição ***
          return post.authorName.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPosts);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: _buildSearchBar(),
      ),
      body: _buildSearchResultsGrid(),
    );
  }

  // Widget da barra de pesquisa
  Widget _buildSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Pesquisar perfis...',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
      ),
    );
  }

  // Widget da grade de resultados
  Widget _buildSearchResultsGrid() {
    if (_allPosts.isEmpty) {
      // Mostra um indicador de carregamento enquanto os posts não são carregados
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 colunas, como no Instagram
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 1, // Imagens quadradas
      ),
      itemCount: _filteredPosts.length,
      itemBuilder: (context, index) {
        final post = _filteredPosts[index];
        return GestureDetector(
          onTap: () {
            // Navega para a tela de detalhes do post
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SinglePostPage(post: post),
              ),
            );
          },
          child: Image.network(
            post.imageUrl,
            fit: BoxFit.cover,
            // Mostra um placeholder enquanto a imagem carrega
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(color: Colors.grey[300]);
            },
            // Mostra um ícone de erro se a imagem falhar
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              );
            },
          ),
        );
      },
    );
  }
}
