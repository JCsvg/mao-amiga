import 'package:flutter/material.dart';
import 'screens/home/feed_screen.dart';
import 'screens/home/notification_screen.dart';
import 'screens/home/profile_screen.dart';
import 'screens/home/search_screen.dart';

class MaoAmiga extends StatefulWidget {
  const MaoAmiga({super.key});

  @override
  State<MaoAmiga> createState() => _MaoAmigaState();
}

class _MaoAmigaState extends State<MaoAmiga> {
  // 1. Removido o 'final' para que a variável possa ser alterada.
  int _currentPage = 0; // <<< MUDANÇA

  // Lista de telas para navegação.
  final List<Widget> _screens = [
    FeedScreen(),
    SearchScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  // 2. Função que será chamada pelo onTap para atualizar o estado.
  void _onItemTapped(int index) {
    // <<< MUDANÇA
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.elementAt(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início', // <<< MUDANÇA (Adicionado label)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (_currentPage == 1)
                  ? Icons.explore_rounded
                  : Icons.explore_outlined,
            ),
            label: 'Busca', // <<< MUDANÇA (Adicionado label)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (_currentPage == 2)
                  ? Icons.notifications_rounded
                  : Icons.notifications_none_rounded,
            ),
            label: 'Notificações', // <<< MUDANÇA (Adicionado label)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil', // <<< MUDANÇA (Adicionado label)
          ),
        ],
        currentIndex: _currentPage,
        // 3. Adicionada a propriedade onTap.
        onTap: _onItemTapped, // <<< MUDANÇA
        // Melhoria de estilo (opcional)
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[800],
        showSelectedLabels:
            false, // Opcional: para esconder os labels se quiser
        showUnselectedLabels:
            false, // Opcional: para esconder os labels se quiser
      ),
    );
  }
}
