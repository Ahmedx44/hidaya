import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/core/config/assets/theme/app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightMode);

  void changeTheme() {
    if (state == lightMode) {
      emit(darkMode);
    } else {
      emit(lightMode);
    }
  }
}
