import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildAppTheme() {
  const Color forest = Color(0xFF2E7D32);
  const Color moss = Color(0xFFA5D6A7);
  const Color sand = Color(0xFFF1F8E9);
  const Color seaFoam = Color(0xFFD9EFE4);
  const Color earth = Color(0xFF6D8E5A);
  const Color ink = Color(0xFF183022);

  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: forest,
    brightness: Brightness.light,
    surface: sand,
  );

  final TextTheme textTheme = GoogleFonts.plusJakartaSansTextTheme().copyWith(
    headlineMedium: GoogleFonts.cormorantGaramond(
      fontSize: 34,
      fontWeight: FontWeight.w700,
      color: ink,
    ),
    headlineSmall: GoogleFonts.cormorantGaramond(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: ink,
    ),
    titleLarge: GoogleFonts.plusJakartaSans(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: ink,
    ),
    bodyLarge: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      height: 1.4,
      color: ink,
    ),
    bodyMedium: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      height: 1.45,
      color: ink.withOpacity(0.82),
    ),
    labelLarge: GoogleFonts.plusJakartaSans(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
    ),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme.copyWith(
      primary: forest,
      secondary: earth,
      tertiary: moss,
      surface: sand,
    ),
    scaffoldBackgroundColor: sand,
    textTheme: textTheme,
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white.withOpacity(0.72),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      margin: EdgeInsets.zero,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: sand.withOpacity(0.92),
      labelTextStyle: MaterialStatePropertyAll<TextStyle>(
        GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 12),
      ),
      indicatorColor: moss.withOpacity(0.4),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: seaFoam,
      selectedColor: moss.withOpacity(0.18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      labelStyle: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w700,
        color: forest,
      ),
    ),
  );
}
