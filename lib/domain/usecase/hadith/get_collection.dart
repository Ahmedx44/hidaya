import 'package:hadith/classes.dart';
import 'package:hidaya/data/source/hadith/hadith_Service.dart';
import 'package:hidaya/service_locator.dart';

class GetCollectionUseCase {
  List<Collection> call() {
    return sl<HadithService>().getCollection();
  }
}
