import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hadith/hadith.dart';
import 'package:hidaya/data/model/hadith/book_model.dart';
import 'package:hidaya/domain/usecase/hadith/get_books.dart';
import 'package:hidaya/presentation/hadith/bloc/hadit_list_book_bloc/hadith_book_list_state.dart';

class HadithListBookCubit extends Cubit<HadithListBookState> {
  final GetBooksUseCase getBooksUseCase;
  HadithListBookCubit(this.getBooksUseCase) : super(HadithListBookIntital());

  void getBooks(Collections collection) {
    emit(HadithListBookLoading());
    final books = getBooksUseCase(BookModel(collection: collection));
    emit(HadithListBookLoaded(collection: books));
  }
}
