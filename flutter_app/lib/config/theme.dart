import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _primaryColor = Color(0xFFE8927C); // soft peach / coral
  static const _secondaryColor = Color(0xFFB8D8BA); // pastel mint
  static const _accentColor = Color(0xFFD4B5D6); // lavender
  static const _backgroundColor = Color(0xFFFAF8F5); // warm off-white
  static const _surfaceColor = Colors.white;
  static const _errorColor = Color(0xFFE57373);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: _primaryColor,
        secondary: _secondaryColor,
        tertiary: _accentColor,
        surface: _surfaceColor,
        error: _errorColor,
      ),
      scaffoldBackgroundColor: _backgroundColor,
      textTheme: GoogleFonts.notoSansKrTextTheme().copyWith(
        headlineLarge: GoogleFonts.notoSansKr(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2D2D2D),
        ),
        headlineMedium: GoogleFonts.notoSansKr(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2D2D2D),
        ),
        titleLarge: GoogleFonts.notoSansKr(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF2D2D2D),
        ),
        bodyLarge: GoogleFonts.notoSansKr(
          fontSize: 16,
          color: const Color(0xFF444444),
        ),
        bodyMedium: GoogleFonts.notoSansKr(
          fontSize: 14,
          color: const Color(0xFF666666),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: GoogleFonts.notoSansKr(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
        color: _surfaceColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF5F3F0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: _primaryColor.withValues(alpha: 0.5), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white.withValues(alpha: 0.9),
        elevation: 0,
        scrolledUnderElevation: 1,
        titleTextStyle: GoogleFonts.notoSansKr(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2D2D2D),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF666666)),
      ),
    );
  }
}
