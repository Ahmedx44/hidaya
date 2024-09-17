import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidaya/core/config/assets/theme/app_color.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: const Color.fromRGBO(255, 255, 255, 1),
    onPrimary: Colors.grey.shade800,
    primary: Color.fromARGB(255, 80, 199, 0),
    inversePrimary: AppColors.background,
    secondary: AppColors.secondary,
    tertiary: AppColors.tertiary,
    onTertiary: Color.fromARGB(255, 212, 247, 202),
  ),
  textTheme: GoogleFonts.amiriTextTheme(),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: AppColors.white),
    titleMedium: TextStyle(color: AppColors.white),
    titleSmall: TextStyle(color: AppColors.white),
  ),
  colorScheme: ColorScheme.light(
    surface: AppColors.background,
    primary: AppColors.primary,
    inversePrimary: AppColors.white,
    secondary: AppColors.secondary,
    tertiary: AppColors.tertiary,
    onTertiary: Color.fromARGB(255, 13, 17, 10),
  ),
);
