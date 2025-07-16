import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Paleta de Cores ---
// É uma boa prática definir suas cores primárias em um só lugar.
const Color _corPrimariaClaro = Color(0xFF005EB8); // Um azul forte e acessível
const Color _corPrimariaEscuro = Color(
  0xFF669DF6,
); // Um azul mais claro para bom contraste no escuro

class ThemeModeApp extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  // =======================================================================
  //                           TEMA CLARO (LIGHT MODE)
  // =======================================================================
  ThemeData get lightMode => ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    // Esquema de cores principal gerado a partir de uma cor "semente"
    colorScheme: ColorScheme.fromSeed(
      seedColor: _corPrimariaClaro,
      brightness: Brightness.light,
    ),

    // Cor de fundo principal do app
    scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Um branco "suave"
    // Tema da AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87, // Cor dos ícones e texto
      elevation: 1,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Tema da Barra de Navegação Inferior
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _corPrimariaClaro,
      unselectedItemColor: Colors.grey,
      elevation: 2,
    ),

    // Estilos de Texto
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),

    // Tema dos Cards
    cardTheme: CardThemeData(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  // =======================================================================
  //                           TEMA ESCURO (DARK MODE)
  // =======================================================================
  ThemeData get darkMode => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    // Esquema de cores principal gerado a partir de uma cor "semente"
    colorScheme: ColorScheme.fromSeed(
      seedColor: _corPrimariaEscuro,
      brightness: Brightness.dark,
    ),

    // Cor de fundo (evitamos o preto puro para conforto visual)
    scaffoldBackgroundColor: const Color(0xFF121212),

    // Tema da AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1F1F1F),
      foregroundColor: Colors.white,
      elevation: 1,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Tema da Barra de Navegação Inferior
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1F1F1F),
      selectedItemColor: _corPrimariaEscuro,
      unselectedItemColor: Colors.grey[600],
      elevation: 2,
    ),

    // Estilos de Texto
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),

    // Tema dos Cards
    cardTheme: CardThemeData(
      elevation: 1,
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  // --- Função para alterar o tema ---
  void alterarTema(bool isDark) {
    _isDarkMode = isDark;
    // CORREÇÃO: notifyListeners() deve ser chamado aqui dentro!
    notifyListeners();
  }
}
