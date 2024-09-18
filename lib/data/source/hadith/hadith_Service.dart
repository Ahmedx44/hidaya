import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';

abstract class HadithService {
  List<Collection> getCollection();
}

class HadithServiceImpl extends HadithService {
  @override
  List<Collection> getCollection() {
    List<Collection> colleciton = getCollections();
    return colleciton;
  }
}
