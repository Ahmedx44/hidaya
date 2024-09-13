import 'package:quran_flutter/models/surah.dart';
import 'package:quran_flutter/quran.dart';

abstract class SurahService {
  Future<Map<int, Surah>> fetchSurah();
}

class SurahServiceImpl extends SurahService {
  @override
  Future<Map<int, Surah>> fetchSurah() async {
    return Quran.getSurahAsMap();
  }
}
