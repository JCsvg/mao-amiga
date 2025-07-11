import 'package:flutter/material.dart';
import 'package:frontend/app/screens/homepage.dart';
import 'package:frontend/app/screens/login_page.dart';
import 'package:frontend/app/screens/notifications_page.dart';
import 'package:frontend/app/screens/search_page.dart';
import 'package:frontend/app/screens/volunteer/volunt_profile_page.dart';

class MaoAmiga extends StatelessWidget {
  MaoAmiga({super.key});

  final List<Widget> _screens = [
    LoginPage(),
    Homepage(),
    SearchPage(),
    NotificationsPage(isONG: true),
    VolunteerProfilePage(isDarkMode: false,),
  ];

  final int _atual = 4;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _screens[_atual],
    );
  }
}
