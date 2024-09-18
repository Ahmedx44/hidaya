import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hidaya/core/config/assets/theme/app_theme.dart';
import 'package:hidaya/firebase_options.dart';
import 'package:hidaya/presentation/auth/pages/authgate.dart';
import 'package:hidaya/service_locator.dart';
import 'package:quran_flutter/quran.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializedDependency();
  await Quran.initialize();
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
      home: const AuthGate(),
    );
  }
}
