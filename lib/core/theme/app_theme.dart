import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// Paleta Clean Soft UI Oficial de Azulito POS
class AppColors {
  static const Color defaultPrimary = Color(0xFF1E40AF); // Azul Rey
  static const Color accent = Color(0xFF0EA5E9);         // Azul Cielo
  static const Color background = Color(0xFFF1F5F9);     // Blanco Frío Suave
  static const Color surface = Color(0xFFFFFFFF);        // Blanco Puro
  static const Color textPrimary = Color(0xFF0F172A);    // Pizarra Oscura
  static const Color textSecondary = Color(0xFF64748B);  // Pizarra Media
  static const Color border = Color(0xFFE2E8F0);         // Pizarra Clara
  static const Color success = Color(0xFF10B981);        // Verde Esmeralda (Online)
  static const Color warning = Color(0xFFF59E0B);        // Naranja Ámbar (Offline/Alerta)
  static const Color danger = Color(0xFFEF4444);         // Rojo Carmesí
}

// Provider de Color Primario Dinámico (Personalizable por Tienda)
final primaryColorProvider = StateNotifierProvider<PrimaryColorNotifier, Color>((ref) {
  return PrimaryColorNotifier();
});

class PrimaryColorNotifier extends StateNotifier<Color> {
  PrimaryColorNotifier() : super(AppColors.defaultPrimary);

  void updateColor(Color newColor) {
    state = newColor;
  }
}

class AppTheme {
  static ThemeData getTheme(Color primaryColor) {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        background: AppColors.background,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: baseTextTheme.copyWith(
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        titleLarge: baseTextTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // Sombra difusa suave (4% opacidad)
  static List<BoxShadow> get softShadow => [
    const BoxShadow(
      color: Color(0x0A0F172A),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];
}
