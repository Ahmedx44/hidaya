import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';
import 'package:hidaya/data/source/hadith/hadith_Service.dart';
import 'package:hidaya/domain/respository/hadith/hadith_reposiotry.dart';
import 'package:hidaya/service_locator.dart';

class HadithReposiotryImpl extends HadithReposiotry {
  @override
  List<Collection> getCollection() {
    return sl<HadithService>().getCollection();
  }

  @override
  List<Book> getBooks(Collections collection) {
    return sl<HadithService>().getBookss(collection);
  }

  @override
  List<Hadith> getHadiths(Collections collection, int bookNum) {
    return sl<HadithService>().getHadiths(collection, bookNum);
  }
}
