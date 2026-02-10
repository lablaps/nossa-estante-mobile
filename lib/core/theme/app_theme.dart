import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Tema do aplicativo Nossa Estante
class AppTheme {
  /// Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.backgroundLight,
        onPrimary: AppColors.textMain,
        onSurface: AppColors.textMain,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  /// Tema escuro
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.backgroundDark,
        onPrimary: AppColors.textMain,
        onSurface: AppColors.white,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: _textTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  /// Tema de tipografia
  static TextTheme get _textTheme {
    return TextTheme(
      // Títulos (usando Plus Jakarta Sans)
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      displaySmall: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),

      // Corpo de texto (usando Noto Sans)
      bodyLarge: GoogleFonts.notoSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.notoSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),

      // Botões
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
      ),
    );
  }

  /// Tema de botões elevados
  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textMain,
        elevation: 8,
        shadowColor: AppColors.primary.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}
