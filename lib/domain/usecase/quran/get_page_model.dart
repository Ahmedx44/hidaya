import 'package:hidaya/data/model/surah/verse_Model.dart';
import 'package:hidaya/domain/respository/quran/surah_reposiotry.dart';
import 'package:hidaya/service_locator.dart';

class GetPageDataUseCase {
  Future<List> call(GetPageModel getpagemodel) async {
    return sl<QuranReposiotry>().getPageData(getpagemodel.pageNUmber);
  }
}
