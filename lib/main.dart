import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/core/config/assets/theme/app_theme.dart';
import 'package:hidaya/domain/usecase/quran/surah_search_usecase.dart';
import 'package:hidaya/firebase_options.dart';
import 'package:hidaya/presentation/auth/pages/authgate.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/surah_state_cubit.dart';
import 'package:hidaya/presentation/search/bloc/search_cubit.dart';
import 'package:hidaya/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_flutter/quran.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializedDependency();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await Quran.initialize();
  // QuranTool quranTool = QuranTool.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FirebasePhoneAuthProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SurahSearchCubit(sl<SurahSearchUsecase>()),
          ),
          BlocProvider(create: (_) => SurahCubit())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          home: const AuthGate(),
        ),
      ),
    );
  }
}
