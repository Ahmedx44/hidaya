import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';

abstract class HadithReposiotry {
  List<Collection> getCollection();
  List<Book> getBooks(Collections collection);
}
