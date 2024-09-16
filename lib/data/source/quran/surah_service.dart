import 'package:quran_flutter/models/surah.dart';
import 'package:quran_flutter/models/verse.dart';
import 'package:quran_flutter/quran.dart';

abstract class SurahService {
  Future<Map<int, Surah>> fetchSurah();
  Future<List<Verse>> fetchQuranVerse(int surahNumber);
}

class SurahServiceImpl extends SurahService {
  @override
  Future<Map<int, Surah>> fetchSurah() async {
    return Quran.getSurahAsMap();
  }

  Future<List<Verse>> fetchQuranVerse(int surahNumber) async {
    return Quran.getSurahVersesAsList(surahNumber);
  }
}
