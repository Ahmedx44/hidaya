import 'package:hidaya/data/source/quran/surah_service.dart';
import 'package:hidaya/domain/respository/quran/surah_reposiotry.dart';
import 'package:hidaya/service_locator.dart';
import 'package:quran_flutter/models/surah.dart';
import 'package:quran_flutter/models/verse.dart';

class SurahRepositoryImpl extends SurahReposiotry {
  @override
  Future<Map<int, Surah>> getSurahAsMap() async {
    return sl<SurahService>().fetchSurah();
  }

  @override
  Future<List<Verse>> getQuranVerse(int surahNumber) {
    return sl<SurahService>().fetchQuranVerse(surahNumber);
  }
}
