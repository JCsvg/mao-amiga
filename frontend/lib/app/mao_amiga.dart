import 'package:flutter/material.dart';
import 'package:frontend/app/screens/homepage.dart';
import 'package:frontend/app/screens/login_page.dart';
import 'package:frontend/app/screens/notifications_page.dart';
import 'package:frontend/app/screens/ong/ong_profile_page.dart';
import 'package:frontend/app/screens/ong/ong_vol_page.dart';
import 'package:frontend/app/screens/profile_page.dart';
import 'package:frontend/app/screens/search_page.dart';

class MaoAmigaApp extends StatefulWidget {
  const MaoAmigaApp({super.key});

  @override
  State<MaoAmigaApp> createState() => _MaoAmigaAppState();
}

class _MaoAmigaAppState extends State<MaoAmigaApp> {
  final List<Widget> _screens = [
    HomePage(),
    SearchPage(),
    NotificationsPage(isONG: false,),
    ProfilePage(),
    OngVolPage(),
    LoginPage(),
    OngProfilePage(),
  ];

  int _controllerPage = 6;

  void _tracePage(int index) {
    setState(() {
      _controllerPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Barra de navegação inferior'),
        ),
        body: _screens[_controllerPage] 
        // _screens.elementAt(_controllerPage),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Inicio',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.explore_outlined),
        //       label: 'Pesquisa',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.notifications_none),
        //       label: 'Notificações',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Perfil',
        //     ),
        //   ],
        //   currentIndex: _controllerPage,
        //   selectedItemColor: Colors.black,
        //   onTap: _tracePage,
        // ),
      ),
    );
  }
}
