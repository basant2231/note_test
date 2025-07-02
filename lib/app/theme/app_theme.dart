import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.card,
    textTheme: TextTheme(
      titleLarge: AppTextStyles.headline(),
      bodyMedium: AppTextStyles.body(),
      titleMedium: AppTextStyles.subtitle(),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      titleTextStyle: AppTextStyles.headline(color: Colors.white),
    ),
    useMaterial3: true,
  );

  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkCard,
    textTheme: TextTheme(
      titleLarge: AppTextStyles.headline(color: AppColors.darkText),
      bodyMedium: AppTextStyles.body(color: AppColors.darkText),
      titleMedium: AppTextStyles.subtitle(color: AppColors.darkSubtitle),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: Colors.white,
      elevation: 4,
      titleTextStyle: AppTextStyles.headline(color: Colors.white),
    ),
    useMaterial3: true,
  );
}
