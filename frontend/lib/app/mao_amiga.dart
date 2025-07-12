import 'package:flutter/material.dart';
import 'package:frontend/app/screens/homepage.dart';
import 'package:frontend/app/screens/login_page.dart';
import 'package:frontend/app/screens/notifications_page.dart';
import 'package:frontend/app/screens/profile_page.dart';
import 'package:frontend/app/screens/search_page.dart';

class MaoAmigaApp extends StatefulWidget {
  const MaoAmigaApp({super.key});

  @override
  State<MaoAmigaApp> createState() => _MaoAmigaAppState();
}

class _MaoAmigaAppState extends State<MaoAmigaApp> {
  final List<Widget> _screens = [
    LoginPage(),
    HomePage(),
    NotificationsPage(),
    SearchPage(),
    ProfilePage(),
  ];

  final controllerPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: controllerPage,
          children: _screens,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
