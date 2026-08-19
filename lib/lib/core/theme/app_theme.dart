import 'package:flutter/material.dart';
import 'tokens.dart';

/// Centralised [ThemeData] for Savvi, derived entirely from [SavColors] etc.
///
/// Text styles mirror the v45 scale:
///   page title 21 (serif) · KPI number 28 (serif) · body 14 · label 12/13 ·
///   chip 10.5–11 · button 15/700. Serif is used ONLY for titles and KPI
///   numbers; everything else is DM Sans.
class AppTheme {
  AppTheme._();

  static ThemeData light() {
    const scheme = ColorScheme.light(
      primary: SavColors.navy,
      onPrimary: Colors.white,
      secondary: SavColors.green,
      onSecondary: SavColors.navy,
      surface: SavColors.surface,
      onSurface: SavColors.txt,
      error: SavColors.red,
      onError: Colors.white,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: SavColors.page,
      fontFamily: SavFonts.sans,
      splashFactory: InkRipple.splashFactory,
    );

    return base.copyWith(
      textTheme: _textTheme(base.textTheme),
      dividerColor: SavColors.border,
      inputDecorationTheme: _inputTheme(),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        insetPadding: EdgeInsets.all(SavSpace.x14),
      ),
      // Enforce the 44px minimum touch target globally.
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }

  static TextTheme _textTheme(TextTheme t) {
    TextStyle serif(double size, {Color color = SavColors.navy}) => TextStyle(
          fontFamily: SavFonts.serif,
          fontSize: size,
          color: color,
          height: 1.15,
        );
    TextStyle sans(double size,
            {FontWeight weight = FontWeight.w500,
            Color color = SavColors.txt}) =>
        TextStyle(
          fontFamily: SavFonts.sans,
          fontSize: size,
          fontWeight: weight,
          color: color,
        );

    return t.copyWith(
      // Serif — titles + KPI numbers only.
      displaySmall: serif(28), // KPI number
      headlineMedium: serif(24),
      headlineSmall: serif(21), // page title
      titleLarge: serif(19),
      titleMedium: serif(16),
      // Sans — everything else.
      bodyLarge: sans(15, weight: FontWeight.w500),
      bodyMedium: sans(14, weight: FontWeight.w500, color: SavColors.txt2),
      bodySmall: sans(12.5, weight: FontWeight.w500, color: SavColors.txt3),
      labelLarge: sans(15, weight: FontWeight.w700),
      labelMedium: sans(13, weight: FontWeight.w700, color: SavColors.txt2),
      labelSmall: sans(11, weight: FontWeight.w700, color: SavColors.txt4),
    );
  }

  static InputDecorationTheme _inputTheme() {
    OutlineInputBorder border(Color c, [double w = 1.5]) => OutlineInputBorder(
          borderRadius: SavRadius.field,
          borderSide: BorderSide(color: c, width: w),
        );
    return InputDecorationTheme(
      filled: true,
      fillColor: SavColors.surface,
      contentPadding: const EdgeInsets.symmetric(
          horizontal: SavSpace.x14, vertical: SavSpace.x12),
      enabledBorder: border(SavColors.border),
      focusedBorder: border(SavColors.navy),
      errorBorder: border(SavColors.red),
      focusedErrorBorder: border(SavColors.red),
      hintStyle: const TextStyle(
        fontFamily: SavFonts.sans,
        fontSize: 15,
        color: SavColors.txt4,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: const TextStyle(
        fontFamily: SavFonts.sans,
        fontSize: 11.5,
        color: SavColors.red,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
