import 'package:flutter/material.dart';
import '../core/constants/colors.dart';
import '../core/constants/text_styles.dart';

abstract final class NafsTheme {
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: NafsColors.primaryDark,
        colorScheme: const ColorScheme.dark(
          primary: NafsColors.accentGold,
          secondary: NafsColors.primaryGreen,
          surface: NafsColors.cardSurface,
          onPrimary: NafsColors.primaryDark,
          onSecondary: NafsColors.ivoryText,
          onSurface: NafsColors.ivoryText,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: NafsTextStyles.displaySmall,
          iconTheme: const IconThemeData(color: NafsColors.ivoryText),
        ),
        cardTheme: CardThemeData(
          color: NafsColors.cardSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: NafsColors.accentGold.withValues(alpha: 0.2),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: NafsColors.accentGold,
            foregroundColor: NafsColors.primaryDark,
            textStyle: NafsTextStyles.buttonText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            elevation: 4,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: NafsColors.accentGold,
            textStyle: NafsTextStyles.labelLarge,
          ),
        ),
        iconTheme: const IconThemeData(color: NafsColors.ivoryText),
        dividerTheme: DividerThemeData(
          color: NafsColors.accentGold.withValues(alpha: 0.2),
          thickness: 1,
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: NafsColors.accentGold,
          inactiveTrackColor: NafsColors.ashMuted.withValues(alpha: 0.3),
          thumbColor: NafsColors.accentGold,
          overlayColor: NafsColors.accentGold.withValues(alpha: 0.2),
          valueIndicatorColor: NafsColors.accentGold,
          valueIndicatorTextStyle: NafsTextStyles.labelLarge.copyWith(
            color: NafsColors.primaryDark,
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return NafsColors.accentGold;
            }
            return NafsColors.ashMuted;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return NafsColors.accentGold.withValues(alpha: 0.3);
            }
            return NafsColors.ashMuted.withValues(alpha: 0.2);
          }),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: NafsColors.cardSurface,
          contentTextStyle: NafsTextStyles.bodyMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
}
