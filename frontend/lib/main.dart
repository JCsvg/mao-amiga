import 'package:flutter/material.dart';
import 'app/mao_amiga.dart';
import 'app/theme_mode_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => ThemeModeApp(), child: MyApp()),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  bool isOng = true;
  @override
  Widget build(BuildContext context) {
    final themeModeApp = context.watch<ThemeModeApp>();

    return MaterialApp(
      title: 'Mão Amiga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeModeApp.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MaoAmiga(isOng: isOng, themeControl: themeModeApp),
    );
  }
}
