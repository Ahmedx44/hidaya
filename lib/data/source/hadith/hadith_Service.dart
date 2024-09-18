import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';

abstract class HadithService {
  List<Collection> getCollection();
  List<Book> getBookss(Collections collection);
}

class HadithServiceImpl extends HadithService {
  @override
  List<Collection> getCollection() {
    List<Collection> colleciton = getCollections();
    return colleciton;
  }

  @override
  List<Book> getBookss(Collections collection) {
    List<Book> books = getBooks(collection);
    return books;
  }
}
