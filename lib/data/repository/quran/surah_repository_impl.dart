import 'package:hidaya/data/source/quran/quran_service.dart';
import 'package:hidaya/domain/respository/quran/surah_reposiotry.dart';
import 'package:hidaya/service_locator.dart';
import 'package:quran/quran.dart';
import 'package:quran_flutter/models/surah.dart';

class QuranReposiotryImpl extends QuranReposiotry {
  @override
  Future<Map<int, Surah>> getSurahAsMap() async {
    return sl<QuranService>().fetchSurah();
  }

  @override
  Future<List> getSurahVerse(int surahNumber) {
    return sl<QuranService>().getSurahVerse(surahNumber);
  }

  @override
  Future<String> getUrlAudio(int surahNumber) {
    return sl<QuranService>().getUrlAudio(surahNumber);
  }

  @override
  RandomVerse getRandomVerse() {
    return sl<QuranService>().getRandoVerse();
  }

  @override
  String getSurah(int surahNumber) {
    return sl<QuranService>().getSurah(surahNumber);
  }

  @override
  String getSurahName(int surahNumber) {
    return sl<QuranService>().getSurahName(surahNumber);
  }
}
