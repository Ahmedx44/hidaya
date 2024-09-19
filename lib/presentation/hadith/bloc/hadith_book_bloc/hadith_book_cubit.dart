import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';
import 'package:hidaya/data/model/hadith/hadith_model.dart';
import 'package:hidaya/domain/usecase/hadith/get_hadith.dart';
import 'package:hidaya/presentation/hadith/bloc/hadith_book_bloc/hadith_book_state.dart';

class HadithBookCubit extends Cubit<HadithBookState> {
  final GetHadithUseCase getHadithUseCase;
  HadithBookCubit(this.getHadithUseCase) : super(HadithBookInitial());

  void loadHadith(Collections collection, int bookNum) {
    emit(HadithBookInitial());
    List<Hadith> hadith =
        getHadithUseCase(HadithModel(collection: collection, bookNum: bookNum));
    emit(HadithBookLoaded(hadiths: hadith));
  }
}
