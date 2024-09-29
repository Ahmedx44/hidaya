import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/common/bloc/theme_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<ThemeCubit>().changeTheme();
          },
          child: Text('change theme'),
        ),
      ),
    );
  }
}
