import 'package:flutter/material.dart';
import 'package:hidaya/core/config/assets/theme/app_color.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: AppColors.white,
    primary: AppColors.primary,
    inversePrimary: AppColors.background,
    secondary: AppColors.secondary,
    tertiary: AppColors.tertiary,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: AppColors.background),
    titleMedium: TextStyle(color: AppColors.background),
    titleSmall: TextStyle(color: AppColors.background),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: AppColors.white),
    titleMedium: TextStyle(color: AppColors.white),
    titleSmall: TextStyle(color: AppColors.white),
  ),
  colorScheme: const ColorScheme.light(
    surface: AppColors.background,
    primary: AppColors.primary,
    inversePrimary: AppColors.white,
    secondary: AppColors.secondary,
    tertiary: AppColors.tertiary,
  ),
);
