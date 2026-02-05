import 'package:flutter/material.dart';

ThemeData buildTheme() {
  const seed = Color(0xFF1F4B99); // ruhiges Blau als Basis
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
    useMaterial3: true,
  );
}
