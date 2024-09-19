import 'package:get_it/get_it.dart';
import 'package:hidaya/data/repository/auth/auth_repository_impl.dart';
import 'package:hidaya/data/repository/quran/surah_repository_impl.dart';
import 'package:hidaya/data/source/auth/auth_firebase_service.dart';
import 'package:hidaya/data/source/hadith/hadith_Service.dart';
import 'package:hidaya/data/source/quran/quran_service.dart';
import 'package:hidaya/domain/respository/auth/auth_repsoitory.dart';
import 'package:hidaya/domain/respository/quran/surah_reposiotry.dart';
import 'package:hidaya/domain/usecase/auth/siginin_usecase.dart';
import 'package:hidaya/domain/usecase/auth/signup_usecase.dart';
import 'package:hidaya/domain/usecase/hadith/get_books.dart';
import 'package:hidaya/domain/usecase/hadith/get_collection.dart';
import 'package:hidaya/domain/usecase/hadith/get_hadith.dart';
import 'package:hidaya/domain/usecase/quran/get_page_model.dart';
import 'package:hidaya/domain/usecase/quran/surah_usecase.dart';

final sl = GetIt.instance;

Future<void> initializedDependency() async {
  sl.registerSingleton<AuthRepsoitory>(
    AuthRepositoryImpl(),
  );

  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );

  sl.registerSingleton<SignupUsecase>(
    SignupUsecase(),
  );
  sl.registerSingleton<SigininUsecase>(
    SigininUsecase(),
  );

  sl.registerSingleton<QuranReposiotry>(
    QuranReposiotryImpl(),
  );

  sl.registerSingleton<SurahUsecase>(
    SurahUsecase(),
  );
  sl.registerSingleton<QuranService>(
    QuranServiceImpl(),
  );
  sl.registerSingleton<GetPageDataUseCase>(
    GetPageDataUseCase(),
  );
  sl.registerSingleton<HadithService>(
    HadithServiceImpl(),
  );
  sl.registerSingleton<GetCollectionUseCase>(
    GetCollectionUseCase(),
  );
  sl.registerSingleton<GetBooksUseCase>(
    GetBooksUseCase(),
  );
  sl.registerSingleton<GetHadithUseCase>(
    GetHadithUseCase(),
  );
}
