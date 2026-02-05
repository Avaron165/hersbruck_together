import 'package:flutter/material.dart';

const goldAccent = Color(0xFFD4AF37);
const goldLight = Color(0xFFE8D5A3);
const darkBackground = Color(0xFF0D0D12);
const darkSurface = Color(0xFF1A1A24);

ThemeData buildTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(
      primary: goldAccent,
      onPrimary: Colors.black,
      secondary: goldLight,
      onSecondary: Colors.black,
      surface: darkSurface,
      onSurface: Colors.white,
      surfaceContainerHighest: Color(0xFF2A2A36),
    ),
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: darkSurface.withValues(alpha: 0.9),
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: goldAccent,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          );
        }
        return TextStyle(
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 12,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: goldAccent, size: 24);
        }
        return IconThemeData(
          color: Colors.white.withValues(alpha: 0.6),
          size: 24,
        );
      }),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: Colors.white54,
      ),
    ),
  );
}
