import 'package:bloc/bloc.dart';
import 'package:hidaya/domain/usecase/quran/get_random_verse.dart';
import 'package:hidaya/domain/usecase/quran/surah_usecase.dart';
import 'package:hidaya/presentation/home/bloc/random_bloc/random_state.dart';

class RandomCubit extends Cubit<RandomState> {
  GetRandomVerseUseCase getRandomVerseUseCase;
  SurahUsecase surahUsecase;
  RandomCubit(this.getRandomVerseUseCase, this.surahUsecase)
      : super(RandomStateInitial());

  getRandomverse() {
    emit(RandomStateLoading());
    final randomverse = getRandomVerseUseCase();
    emit(RandomStateLoaded(randomVerse: randomverse));
  }
}
