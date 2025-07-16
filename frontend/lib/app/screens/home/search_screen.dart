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
  // Lista para armazenar todos os posts carregados
  List<PostModel> _allPosts = [];
  // Lista para armazenar os posts filtrados
  List<PostModel> _filteredPosts = [];

  // Controlador para a busca por texto
  final TextEditingController _searchController = TextEditingController();

  // Usa um Set para armazenar múltiplos tipos de ONG selecionados
  final Set<String> _selectedOngTypes = {};

  // Lista de tipos de ONG para o menu de filtro
  final List<String> _ongTypes = [
    'animais',
    'meio_ambiente',
    'social',
    'educacao',
    'saude',
    'direitos_humanos',
    'cultura',
  ];

  @override
  void initState() {
    super.initState();
    _loadPostsAndSetupListener();
  }

  // Carrega os posts do JSON e configura o listener da busca
  Future<void> _loadPostsAndSetupListener() async {
    // Ajuste o caminho do seu JSON se for diferente
    final String jsonString = await rootBundle.loadString(
      'lib/data/posts.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);

    setState(() {
      _allPosts = jsonList
          .map((jsonPost) => PostModel.fromJson(jsonPost))
          .toList();
      _filterPosts(); // Aplica o filtro inicial
    });

    _searchController.addListener(_filterPosts);
  }

  // Filtra os posts com base no texto e nas categorias selecionadas
  void _filterPosts() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredPosts = _allPosts.where((post) {
        // Condição 1: O post deve ser de um tipo de ONG conhecido
        final isOng = _ongTypes.contains(post.typeOng);
        if (!isOng) return false;

        // Condição 2: Filtro por nome do autor (texto da busca)
        final matchesQuery = post.authorName.toLowerCase().contains(query);

        // Condição 3: Filtro por tipos de ONG selecionados
        // Se nenhum filtro estiver selecionado, mostra todos.
        // Se houver filtros, o tipo do post deve estar na lista de selecionados.
        final matchesFilter =
            _selectedOngTypes.isEmpty ||
            _selectedOngTypes.contains(post.typeOng);

        return matchesQuery && matchesFilter;
      }).toList();
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
      appBar: AppBar(elevation: 0, title: _buildSearchBar()),
      body: _buildSearchResultsGrid(),
    );
  }

  // Widget da barra de pesquisa com o botão de filtro
  Widget _buildSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Pesquisar perfis de ONGs...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
              ),
            ),
          ),
          // Botão de Filtro com seleção múltipla
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list, color: Colors.grey),
            onSelected: (String result) {
              setState(() {
                if (result == 'limpar') {
                  _selectedOngTypes.clear();
                } else {
                  // Adiciona ou remove o tipo do set de filtros
                  if (_selectedOngTypes.contains(result)) {
                    _selectedOngTypes.remove(result);
                  } else {
                    _selectedOngTypes.add(result);
                  }
                }
                _filterPosts(); // Aplica os filtros
              });
            },
            itemBuilder: (BuildContext context) {
              return [
                // Opções para cada tipo de ONG
                ..._ongTypes.map((String type) {
                  return CheckedPopupMenuItem<String>(
                    value: type,
                    checked: _selectedOngTypes.contains(
                      type,
                    ), // Marca se estiver selecionado
                    child: Text(
                      type
                          .replaceAll('_', ' ')
                          .replaceFirst(type[0], type[0].toUpperCase()),
                    ),
                  );
                }).toList(),
                // Divisor e opção para limpar os filtros
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'limpar',
                  child: Text('Limpar Filtros'),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }

  // Widget da grade de resultados
  Widget _buildSearchResultsGrid() {
    if (_allPosts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_filteredPosts.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum resultado encontrado.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 1,
      ),
      itemCount: _filteredPosts.length,
      itemBuilder: (context, index) {
        final post = _filteredPosts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SinglePostPage(post: post, isOng: false),
              ),
            );
          },
          child: Image.network(
            post.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(color: Colors.grey[300]);
            },
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
