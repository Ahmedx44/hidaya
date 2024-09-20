import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/quran/surah_usecase.dart';
import 'package:hidaya/presentation/home/bloc/search_bloc/search_state.dart';

class SurahSearchCubit extends Cubit<SurahSearchState> {
  final SurahUsecase getSurahUsecase;

  SurahSearchCubit(this.getSurahUsecase) : super(SurahSearchInitial());

  void searchSurah(String query) async {
    emit(SurahSearchLoading());
    try {
      final surahMap = await getSurahUsecase();
      // final filteredSurahs = surahMap.where((key, surah) =>
      // //     surah.name.toLowerCase().contains(query.toLowerCase()));
      // emit(SurahSearchLoaded(filteredSurahs));
    } catch (e) {
      emit(SurahSearchError());
    }
  }
}
