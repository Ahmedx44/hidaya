import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/data/source/quran/surah_service.dart';
import 'package:hidaya/domain/usecase/quran/allverse_useCase.dart';
import 'package:hidaya/presentation/quran/Bloc/quran_page_state.dart';
import 'package:hidaya/service_locator.dart';

class QuranPageCubit extends Cubit<QuranPageState> {
  AllverseUsecase allverseUsecase;
  QuranPageCubit(this.allverseUsecase) : super(QuranPageIntitial());

  void fetchQuranVerse(int surahNumber) async {
    emit(QuranPageLoading());
    var result = await sl<SurahService>().fetchQuranVerse(surahNumber);
    emit(QuranPageLoaded(verse: result));
  }
}
