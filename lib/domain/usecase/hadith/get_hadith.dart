import 'package:hadith/classes.dart';
import 'package:hidaya/data/model/hadith/hadith_model.dart';
import 'package:hidaya/data/source/hadith/hadith_Service.dart';
import 'package:hidaya/service_locator.dart';

class GetHadithUseCase {
  List<Hadith> call(HadithModel params) {
    return sl<HadithService>().getHadiths(params.collection, params.bookNum);
  }
}
