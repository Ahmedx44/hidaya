import 'package:quran_flutter/models/surah.dart';

abstract class SurahReposiotry {
  Future<Map<int, Surah>> getSurahAsMap();
  Future<List> getQuranVerse(int surahNumber);
}
