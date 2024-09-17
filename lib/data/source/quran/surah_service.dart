import 'package:quran_flutter/models/surah.dart';
import 'package:quran_flutter/quran.dart';
import 'package:quran/quran.dart' as quran;

abstract class QuranService {
  Future<Map<int, Surah>> fetchSurah();
  Future<List> getPageData(int surahNumber);
}

class QuranServiceImpl extends QuranService {
  @override
  Future<Map<int, Surah>> fetchSurah() async {
    return Quran.getSurahAsMap();
  }

  Future<List<dynamic>> getPageData(int pageNumber) async {
    return quran.getVersesTextByPage(pageNumber, verseEndSymbol: true);
  }
}
