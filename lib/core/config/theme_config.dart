import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Configuración de tema de la aplicación Betondecken
class ThemeConfig {
  // Colores corporativos de Betondecken - Prefabricados de concreto
  static const Color blanco = Color(0xFFF5F5F5);
  static const Color negro = Color(0xFF1A1A1A);
  static const Color rojo = Color(0xFFA65248); // Color corporativo principal
  static const Color mostaza = Color(0xFFC7A978); // Acento cálido
  static const Color gris = Color(0xFF585C5F);
  static const Color grisDashboard = Color(0xFFC5C2C2);

  // Aliases para facilidad de uso
  static const Color primaryColor = rojo;
  static const Color secondaryColor = mostaza;
  static const Color textPrimary = negro;
  static const Color textSecondary = gris;
  static const Color backgroundColor = blanco;
  static const Color errorColor = Color(0xFFD32F2F);

  // Tema claro moderno
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.interTextTheme(), // Fuente Inter moderna y legible
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      brightness: Brightness.light,
      surface: blanco,
      background: blanco,
    ),
    scaffoldBackgroundColor: blanco,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: negro,
      surfaceTintColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: grisDashboard, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: grisDashboard, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: errorColor, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: errorColor, width: 2),
      ),
    ),
  );

  // Tema oscuro moderno
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      brightness: Brightness.dark,
      surface: negro,
      background: const Color(0xFF0F0F0F),
    ),
    scaffoldBackgroundColor: negro,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: blanco,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );
}
