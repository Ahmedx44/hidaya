import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/quran/surah_search_usecase.dart';
import 'package:hidaya/presentation/surah_search/bloc/search_state.dart';

class SurahSearchCubit extends Cubit<SearchState> {
  final SurahSearchUsecase surahSearchUsecase;

  SurahSearchCubit(this.surahSearchUsecase) : super(SearchStateIntital());

  void searchSurah(String query) async {
    if (query.isEmpty) {
      emit(SearchStateIntital());
    } else {
      emit(SearchStateLoading());
      try {
        final surahMap = await surahSearchUsecase(query);
        print('Search results: $surahMap'); // Add this debug print statement
        if (surahMap.isEmpty) {
          emit(SearchStateLoaded(surahMap: {}));
        } else {
          emit(SearchStateLoaded(surahMap: surahMap));
        }
      } catch (e) {
        print('Error fetching Surah data: $e');
        emit(SearchStateError());
      }
    }
  }
}
