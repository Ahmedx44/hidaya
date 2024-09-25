import 'package:get_it/get_it.dart';
import 'package:hidaya/data/repository/auth/auth_repository_impl.dart';
import 'package:hidaya/data/repository/quran/surah_repository_impl.dart';
import 'package:hidaya/data/source/auth/auth_firebase_service.dart';
import 'package:hidaya/data/source/hadith/hadith_Service.dart';
import 'package:hidaya/data/source/location/location_service.dart';
import 'package:hidaya/data/source/quran/quran_service.dart';
import 'package:hidaya/data/source/user/userService.dart';
import 'package:hidaya/domain/respository/auth/auth_repsoitory.dart';
import 'package:hidaya/domain/respository/quran/surah_reposiotry.dart';
import 'package:hidaya/domain/usecase/auth/siginin_usecase.dart';
import 'package:hidaya/domain/usecase/auth/signup_usecase.dart';
import 'package:hidaya/domain/usecase/hadith/get_books.dart';
import 'package:hidaya/domain/usecase/hadith/get_collection.dart';
import 'package:hidaya/domain/usecase/hadith/get_hadith.dart';
import 'package:hidaya/domain/usecase/location/getLocation.dart';
import 'package:hidaya/domain/usecase/quran/get_page_model.dart';
import 'package:hidaya/domain/usecase/quran/get_random_verse.dart';
import 'package:hidaya/domain/usecase/quran/surah_search_usecase.dart';
import 'package:hidaya/domain/usecase/quran/surah_usecase.dart';
import 'package:hidaya/domain/usecase/time/time_usecase.dart';
import 'package:hidaya/domain/usecase/user/get_user_usecase.dart';
import 'package:hidaya/domain/usecase/user/update_user.dart';

final sl = GetIt.instance;

Future<void> initializedDependency() async {
  //SERVICES
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );
  sl.registerSingleton<HadithService>(
    HadithServiceImpl(),
  );

  sl.registerSingleton<QuranService>(
    QuranServiceImpl(),
  );
  sl.registerSingleton<LocationService>(
    LocationServiceImpl(),
  );

  sl.registerSingleton<UserService>(
    UserServiceImpl(),
  );

  //USECASES

  sl.registerSingleton<SignupUsecase>(
    SignupUsecase(),
  );
  sl.registerSingleton<SigininUsecase>(
    SigininUsecase(),
  );
  sl.registerSingleton<SurahUsecase>(
    SurahUsecase(),
  );
  sl.registerSingleton<GetPageDataUseCase>(
    GetPageDataUseCase(),
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
  sl.registerSingleton<GetlocationUseCase>(
    GetlocationUseCase(),
  );

  sl.registerSingleton<TimeUsecase>(
    TimeUsecase(),
  );
  sl.registerSingleton<SurahSearchUsecase>(
    SurahSearchUsecase(),
  );
  sl.registerSingleton<GetRandomVerseUseCase>(
    GetRandomVerseUseCase(),
  );
  sl.registerSingleton<GetUserUsecase>(
    GetUserUsecase(),
  );

  sl.registerSingleton<UpdateUser>(
    UpdateUser(),
  );

//REPOSITORYS
  sl.registerSingleton<AuthRepsoitory>(
    AuthRepositoryImpl(),
  );
  sl.registerSingleton<QuranReposiotry>(
    QuranReposiotryImpl(),
  );
}
