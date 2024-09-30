import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/common/bloc/theme_cubit.dart';
import 'package:hidaya/core/config/assets/theme/app_theme.dart';
import 'package:hidaya/firebase_options.dart';
import 'package:hidaya/presentation/auth/pages/authgate.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/surah_state_cubit.dart';
import 'package:hidaya/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializedDependency();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  // QuranTool quranTool = QuranTool.init();
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(),
  // ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => SurahCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, theme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: theme,
              theme: lightMode,
              darkTheme: darkMode,
              home: const AuthGate(),
            );
          },
        ),
      ),
    );
  }
}
