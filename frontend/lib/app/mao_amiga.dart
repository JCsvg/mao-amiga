import 'package:flutter/material.dart';
import '../app/screens/home/feed_screen.dart';
import '../app/screens/home/notification_screen.dart';
import '../app/screens/home/profile_screen.dart';
import '../app/screens/home/search_screen.dart';
import '../app/theme_mode_app.dart';

// ignore: must_be_immutable
class MaoAmiga extends StatefulWidget {
  final ThemeModeApp themeControl;
  final isOng;

  const MaoAmiga({super.key, required this.themeControl, this.isOng});

  @override
  State<MaoAmiga> createState() => _MaoAmigaState();
}

class _MaoAmigaState extends State<MaoAmiga> {
  int _currentPage = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      FeedScreen(isOng: widget.isOng),
      SearchScreen(),
      NotificationScreen(isOng: widget.isOng),
      ProfileScreen(isOng: widget.isOng, themeControl: widget.themeControl),
    ];

    return Scaffold(
      body: screens.elementAt(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon((_currentPage == 0) ? Icons.home : Icons.home_outlined),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (_currentPage == 1)
                  ? Icons.explore_rounded
                  : Icons.explore_outlined,
            ),
            label: 'Busca',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (_currentPage == 2)
                  ? Icons.notifications_rounded
                  : Icons.notifications_none_rounded,
            ),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (_currentPage == 3) ? Icons.person : Icons.person_outlined,
            ),
            label: 'Perfil',
          ),
        ],
        currentIndex: _currentPage,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
