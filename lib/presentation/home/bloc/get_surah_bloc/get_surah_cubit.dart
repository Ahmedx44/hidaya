import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/quran/get_surah_name.dart';
import 'package:hidaya/presentation/home/bloc/get_surah_bloc/get_surah_state.dart';

class GetSurahCubit extends Cubit<GetSurahState> {
  GetSurahNameUseCase getSurahNameUseCase;
  GetSurahCubit(this.getSurahNameUseCase) : super(GetSurahInitial());

  getSurah(int surahNumber) {
    emit(GetSurahLoading());
    final result = getSurahNameUseCase(surahNumber);
    emit(GetSurahLoaded(surah: result));
  }
}
