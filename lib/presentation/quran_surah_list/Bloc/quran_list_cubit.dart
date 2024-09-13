import 'package:bloc/bloc.dart';
import 'package:hidaya/domain/usecase/surah/surah_usecase.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/quran_list_state.dart';

class SurahListCubit extends Cubit<SurahListState> {
  final SurahUsecase surahUsecase;

  SurahListCubit(this.surahUsecase) : super(SurahListInitial());

  void fetchSurah() async {
    try {
      emit(SurahListLoading());
      final surah = await surahUsecase();
      emit(SurahListLoaded(surhas: surah));
    } catch (e) {
      emit(SurahListFailed());
    }
  }
}
