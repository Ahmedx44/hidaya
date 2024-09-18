import 'package:hadith/classes.dart';
import 'package:hidaya/data/model/hadith/hadith_model.dart';
import 'package:hidaya/data/source/hadith/hadith_Service.dart';
import 'package:hidaya/service_locator.dart';

class GetBooksUseCase {
  List<Book> call(BookModel params) {
    return sl<HadithService>().getBookss(params.collection);
  }
}
