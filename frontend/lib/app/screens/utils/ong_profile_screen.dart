import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/screens/utils/single_post_page.dart';
import '../../../app/theme_mode_app.dart';
import '../../../model/avaliacao_model.dart';
import '../../../model/event_description_model.dart';
import '../../../model/post_model.dart';
import '../../../widgets/avaliacao_widget.dart';
import '../../../widgets/event_card_widget.dart';

class OngProfileScreen extends StatefulWidget {
  final ThemeModeApp themeControl;
  final bool isOng;

  const OngProfileScreen({
    super.key,
    required this.themeControl,
    required this.isOng,
  });

  @override
  State<OngProfileScreen> createState() => _OngProfileScreenState();
}

class _OngProfileScreenState extends State<OngProfileScreen> {
  late Future<List<AvaliacaoModel>> _avaliacoesFuture;
  late Future<List<EventDescriptionModel>> _eventosFuture;
  late Future<List<PostModel>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _avaliacoesFuture = _loadAvaliacoes();
    _eventosFuture = _loadEventos();
    _postsFuture = _loadPosts();
  }

  Future<List<AvaliacaoModel>> _loadAvaliacoes() async {
    final jsonString = await rootBundle.loadString('lib/data/avaliacoes.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => AvaliacaoModel.fromJson(json)).toList();
  }

  Future<List<EventDescriptionModel>> _loadEventos() async {
    final jsonString = await rootBundle.loadString('lib/data/events.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => EventDescriptionModel.fromJson(json))
        .toList();
  }

  Future<List<PostModel>> _loadPosts() async {
    final jsonString = await rootBundle.loadString('lib/data/posts.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => PostModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'lib/assets/banner_vida_animal.jpg',
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [Colors.black87, Colors.transparent],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              'lib/assets/logo_vida_animal.jpeg',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Patas Amigas ONG',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quem somos?', style: textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Somos uma ONG dedicada a cuidar de animais de rua, oferecendo resgate, reabilitação e lares amorosos por meio da adoção responsável. Promovemos eventos, campanhas de conscientização e ações solidárias para transformar vidas. Seja voluntário(a), doe e ajude a fazer a diferença!',
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Modo escuro', style: textTheme.bodyMedium),
                        Switch(
                          value: widget.themeControl.isDarkMode,
                          onChanged: (value) {
                            widget.themeControl.alterarTema(value);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Eventos próximos', style: textTheme.titleMedium),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 140,
                      child: FutureBuilder<List<EventDescriptionModel>>(
                        future: _eventosFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError || !snapshot.hasData) {
                            return const Center(
                              child: Text(
                                'Não foi possível carregar os eventos.',
                              ),
                            );
                          }
                          final eventos = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: eventos.length,
                            itemBuilder: (context, index) {
                              return EventCardWidget(
                                event: eventos[index],
                                isOng: widget.isOng,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                const TabBar(
                  tabs: [
                    Tab(text: 'Mais sobre'),
                    Tab(text: 'Posts'),
                    Tab(text: 'Avaliações'),
                  ],
                ),
                backgroundColor: theme.scaffoldBackgroundColor,
              ),
              pinned: true,
            ),
          ],

          body: TabBarView(
            children: [
              ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Text(
                    'Localização e horário de funcionamento',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  const _InfoRow(
                    icon: Icons.location_on_outlined,
                    text:
                        'Av. Brasília, 3080 - Rodocentro, Londrina - PR, 86079-080',
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(
                    icon: Icons.access_time_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seg - Sex: 08h - 20h',
                          style: textTheme.bodyLarge,
                        ),
                        Text(
                          'Sáb - Dom: 12h - 18h',
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 40),
                  Text('Contatos', style: textTheme.titleMedium),
                  const SizedBox(height: 16),
                  const _InfoRow(
                    icon: Icons.phone_outlined,
                    text: '(43) 99852-7855',
                  ),
                  const SizedBox(height: 16),
                  const _InfoRow(
                    icon: Icons.email_outlined,
                    text: 'contato@patasamigas.com.br',
                  ),
                  const SizedBox(height: 16),
                  const _InfoRow(
                    icon: Icons.camera_alt_outlined,
                    text: '@patasamigasong',
                  ),
                  const Divider(height: 40),
                  Text('Como Ajudar', style: textTheme.titleMedium),
                  const SizedBox(height: 16),
                  _InfoRow(
                    icon: Icons.pix,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chave Pix (CNPJ)', style: textTheme.bodyLarge),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '12.345.678/0001-99',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy, size: 20),
                              onPressed: () {
                                Clipboard.setData(
                                  const ClipboardData(
                                    text: '12.345.678/0001-99',
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Chave Pix copiada!'),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              FutureBuilder<List<PostModel>>(
                future: _postsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(
                      child: Text('Não foi possível carregar os posts.'),
                    );
                  }
                  final ongPosts = snapshot.data!
                      .where((post) => post.authorName == 'Patas Amigas ONG')
                      .toList();

                  if (ongPosts.isEmpty) {
                    return const Center(child: Text('Nenhum post encontrado.'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(4),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                    itemCount: ongPosts.length,
                    itemBuilder: (context, index) {
                      final post = ongPosts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SinglePostPage(
                                post: post,
                                isOng: widget.isOng,
                              ),
                            ),
                          );
                        },
                        child: Image.network(post.imageUrl, fit: BoxFit.cover),
                      );
                    },
                  );
                },
              ),
              FutureBuilder<List<AvaliacaoModel>>(
                future: _avaliacoesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(
                      child: Text('Não foi possível carregar as avaliações.'),
                    );
                  }
                  final avaliacoes = snapshot.data!;
                  final double media = avaliacoes.isNotEmpty
                      ? avaliacoes.map((a) => a.nota).reduce((a, b) => a + b) /
                            avaliacoes.length
                      : 0.0;
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      const SizedBox(height: 24),
                      Center(
                        child: Text(
                          media.toStringAsFixed(1),
                          style: textTheme.displayLarge,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (i) => Icon(
                            Icons.star,
                            color: theme.colorScheme.primary,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          "${avaliacoes.length} avaliações",
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      const Divider(height: 32),
                      ...avaliacoes
                          .map(
                            (avaliacao) =>
                                AvaliacaoWidget(avaliacao: avaliacao),
                          )
                          .toList(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, {required this.backgroundColor});

  final TabBar _tabBar;
  final Color backgroundColor;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: backgroundColor, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return backgroundColor != oldDelegate.backgroundColor;
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String? text;
  final Widget? child;

  const _InfoRow({required this.icon, this.text, this.child})
    : assert(text != null || child != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        Expanded(
          child:
              child ??
              Text(text!, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}
