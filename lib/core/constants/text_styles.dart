import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

abstract final class NafsTextStyles {
  static TextStyle displayLarge = GoogleFonts.amiri(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: NafsColors.ivoryText,
  );

  static TextStyle displayMedium = GoogleFonts.amiri(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: NafsColors.ivoryText,
  );

  static TextStyle displaySmall = GoogleFonts.amiri(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: NafsColors.ivoryText,
  );

  static TextStyle headlineMedium = GoogleFonts.amiri(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: NafsColors.ivoryText,
  );

  static TextStyle bodyLarge = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: NafsColors.ivoryText,
  );

  static TextStyle bodyMedium = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: NafsColors.ivoryText,
  );

  static TextStyle bodySmall = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: NafsColors.ashMuted,
  );

  static TextStyle labelLarge = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: NafsColors.ivoryText,
  );

  static TextStyle labelMedium = GoogleFonts.dmSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: NafsColors.ashMuted,
  );

  static TextStyle buttonText = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: NafsColors.primaryDark,
  );

  static TextStyle arabicDisplay = GoogleFonts.scheherazadeNew(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: NafsColors.accentGold,
  );

  static TextStyle arabicBody = GoogleFonts.scheherazadeNew(
    fontSize: 18,
    color: NafsColors.ivoryText,
  );
}
