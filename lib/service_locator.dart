import 'package:get_it/get_it.dart';
import 'package:hidaya/data/repository/auth/auth_repository_impl.dart';
import 'package:hidaya/data/source/auth/auth_firebase_service.dart';
import 'package:hidaya/domain/respository/auth/auth_repsoitory.dart';
import 'package:hidaya/domain/usecase/auth/siginin_usecase.dart';
import 'package:hidaya/domain/usecase/auth/signup_usecase.dart';

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
}
