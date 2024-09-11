import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hidaya/core/config/assets/theme/app_theme.dart';
import 'package:hidaya/firebase_options.dart';
import 'package:hidaya/presentation/Page/onboarding_Screen/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      home: const OnboardingScreen(),
    );
  }
}
