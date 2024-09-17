import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/data/model/surah/verse_Model.dart';
import 'package:hidaya/domain/usecase/quran/get_page_model.dart';
import 'package:hidaya/presentation/quran/Bloc/quran_page_state.dart';

class QuranPageCubit extends Cubit<QuranPageState> {
  final GetPageDataUseCase getPageDataUseCase;
  QuranPageCubit(this.getPageDataUseCase) : super(QuranPageIntitial());

  Future<void> loadQuranPage(int pageNumber) async {
    try {
      emit(QuranPageLoading());
      final quranPage =
          await getPageDataUseCase(GetPageModel(pageNUmber: pageNumber));
      emit(QuranPageLoaded(verse: quranPage));
    } catch (e) {
      print('error');
    }
  }
}
