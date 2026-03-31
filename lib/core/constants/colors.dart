import 'package:flutter/material.dart';

abstract final class NafsColors {
  static const Color primaryDark = Color(0xFF0D1F1A);
  static const Color primaryGreen = Color(0xFF1B4332);
  static const Color accentGold = Color(0xFFC9A84C);
  static const Color softGoldLight = Color(0xFFE8C97A);
  static const Color midnightBlue = Color(0xFF0F172A);
  static const Color ivoryText = Color(0xFFF5F0E8);
  static const Color ashMuted = Color(0xFF8B9A8E);
  static const Color cardSurface = Color(0xFF162520);
  static const Color overlayBlack = Color(0xD9000000);

  static const LinearGradient goldGradient = LinearGradient(
    colors: [accentGold, Color(0xFFA07830)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkVignette = LinearGradient(
    colors: [Colors.transparent, Color(0x40000000)],
    begin: Alignment.center,
    end: Alignment.bottomCenter,
  );
}
