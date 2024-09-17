import 'package:hidaya/data/source/quran/surah_service.dart';
import 'package:hidaya/domain/respository/quran/surah_reposiotry.dart';
import 'package:hidaya/service_locator.dart';
import 'package:quran_flutter/models/surah.dart';

class QuranReposiotryImpl extends QuranReposiotry {
  @override
  Future<Map<int, Surah>> getSurahAsMap() async {
    return sl<QuranService>().fetchSurah();
  }

  @override
  Future<List> getPageData(int pageNumber) {
    return sl<QuranService>().getPageData(pageNumber);
  }
}
