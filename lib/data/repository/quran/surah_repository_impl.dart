import 'package:hidaya/data/source/quran/surah_service.dart';
import 'package:hidaya/domain/respository/surah/surah_reposiotry.dart';
import 'package:hidaya/service_locator.dart';
import 'package:quran_flutter/models/surah.dart';

class SurahRepositoryImpl extends SurahReposiotry {
  @override
  Future<Map<int, Surah>> getSurahAsMap() async {
    return sl<SurahService>().fetchSurah();
  }
}
