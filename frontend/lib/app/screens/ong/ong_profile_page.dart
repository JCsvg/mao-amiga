import 'package:flutter/material.dart';
import 'package:frontend/models/event_card.dart';
import 'package:frontend/models/avaliacoes.dart';

class OngProfilePage extends StatelessWidget {
  OngProfilePage({super.key});

  final avaliacoes = [
      Avaliacao(
        nome: "José Roberto Souza",
        data: "01/12/2024",
        nota: 4.0,
      ),
      Avaliacao(
        nome: "Camila Nascimento Alves",
        data: "01/12/2024",
        nota: 5.0,
      ),
      Avaliacao(
        nome: "Maria Eduarda Souza",
        data: "29/11/2024",
        nota: 5.0,
        comentario:
            "Participar do evento da Vida Animal foi incrível! Ver o cuidado com os animais e ajudar a encontrar lares amorosos foi muito gratificante. A equipe é acolhedora e tudo foi super bem organizado. Quero muito participar novamente!",
      ),
      Avaliacao(
        nome: "Leonardo Rocha Barbosa",
        data: "28/11/2024",
        nota: 5.0,
        comentario:
            "Participar da campanha de adoção da Vida Animal mudou minha vida. Ver os animais...",
      ),
    ];

  @override
  Widget build(BuildContext context) {
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
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage('lib/assets/logo_vida_animal.jpeg'),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Vida Animal - ONG',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 25),
                                  Icon(Icons.star, color: Colors.amber, size: 25),
                                  Icon(Icons.star, color: Colors.amber, size: 25),
                                  Icon(Icons.star, color: Colors.amber, size: 25),
                                  Icon(Icons.star, color: Colors.amber, size: 25),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  spacing: 15,
                                  children: [
                                    ElevatedButton(onPressed: () {}, child: Text('Seguir')),
                                    ElevatedButton(onPressed: () {}, child: Text('Avaliar')),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      'Quem somos?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'Somos uma ONG dedicada a cuidar de animais de rua, oferecendo resgate, reabilitação e lares amorosos por meio da adoção responsável. Promovemos eventos, campanhas de conscientização e ações solidárias para transformar vidas. Seja voluntário(a), doe e ajude a fazer a diferença!',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Eventos próximos',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          EventCard(
                              date: '15/12',
                              time: '14h - 18h',
                              title: 'Arrecadação de ração'),
                          EventCard(
                              date: '20/12',
                              time: '12h - 18h',
                              title: 'Campanha de adoção'),
                          EventCard(
                              date: '10/01',
                              time: '16h - 20h',
                              title: 'Evento solidário'),
                          EventCard(
                              date: '11/01',
                              time: '16h - 20h',
                              title: 'Evento solidário'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const TabBar(
                tabs: [
                  Tab(text: 'Mais sobre'),
                  Tab(text: 'Posts'),
                  Tab(text: 'Avaliações'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // TabBar -> Mais sobre
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Informações detalhadas sobre a ONG.'),
                    ),
                    // TabBar -> Posts
                    const Center(child: Text('Posts em breve...')),
                    // TabBar -> Avaliações
                    Column(
                      children: [
                        const SizedBox(height: 24),
                        const Center(
                          child: Text(
                            "4,8",
                            style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.black, size: 24),
                            Icon(Icons.star, color: Colors.black, size: 24),
                            Icon(Icons.star, color: Colors.black, size: 24),
                            Icon(Icons.star, color: Colors.black, size: 24),
                            Icon(Icons.star, color: Colors.black, size: 24),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "169 avaliações",
                          style: TextStyle(color: Colors.black54),
                        ),
                        const Divider(height: 32),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                            child: ListView(
                              children: avaliacoes
                                .map((avaliacao) => AvaliacaoWidget(avaliacao: avaliacao))
                                .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}