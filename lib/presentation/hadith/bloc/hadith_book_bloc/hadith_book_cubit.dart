import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hadith/hadith.dart';
import 'package:hidaya/data/model/hadith/hadith_model.dart';
import 'package:hidaya/domain/usecase/hadith/get_books.dart';
import 'package:hidaya/presentation/hadith/bloc/hadith_book_bloc/hadith_book_state.dart';

class HadithBookCubit extends Cubit<HadithBookState> {
  final GetBooksUseCase getBooksUseCase;
  HadithBookCubit(this.getBooksUseCase) : super(HadithBookIntital());

  void getBooks(Collections collection) {
    emit(HadithBookLoading());
    final books = getBooksUseCase(BookModel(collection: collection));
    emit(HadithBookLoaded(collection: books));
  }
}
