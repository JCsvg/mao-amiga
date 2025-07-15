import 'package:flutter/material.dart';
import 'package:frontend/app/screens/homepage.dart';
import '../../models/post.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool mostrarFiltros = false;

  final List<String> filtros = [
    "#animais",
    "#meio-ambiente",
    "#educação",
    "#saude",
    "#pessoas",
    "#inclusão",
    "#comunidade",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisar ONGs e projetos"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Barra de pesquisa + botão de filtro
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Pesquisar ONGs e projetos",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      setState(() {
                        mostrarFiltros = !mostrarFiltros;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.tune, size: 24),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),

              // Filtros visíveis no topo
              if (mostrarFiltros)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: filtros
                        .map((f) => Chip(
                              label: Text(f),
                              backgroundColor: Colors.grey[200],
                            ))
                        .toList(),
                  ),
                ),
              // Posts
              ListBody(
                children: HomePage().posts.map((postData) => Post(post: postData)).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
