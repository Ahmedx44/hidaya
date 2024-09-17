import 'package:quran_flutter/models/surah.dart';

abstract class QuranReposiotry {
  Future<Map<int, Surah>> getSurahAsMap();
  Future<List> getPageData(int pageNumber);
}
