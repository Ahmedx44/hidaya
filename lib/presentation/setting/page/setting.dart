import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/common/bloc/theme_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Text(
                'Dark Mode',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              trailing: Switch(
                activeColor: Theme.of(context).colorScheme.primary,
                value: isDarkMode,
                onChanged: (value) {
                  context.read<ThemeCubit>().changeTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
