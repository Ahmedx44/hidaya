import 'package:quran/quran.dart';
import 'package:quran_flutter/models/surah.dart';
import 'package:quran_flutter/quran.dart';
import 'package:quran/quran.dart' as quran;

abstract class QuranService {
  Future<Map<int, Surah>> fetchSurah();
  Future<List> getSurahVerse(int surahNumber);
  Future<String> getUrlAudio(int surahNumber);
  String getSurah(int surahNumber);
  RandomVerse getRandoVerse();
  String getSurahName(int surahNumber);
}

class QuranServiceImpl extends QuranService {
  @override
  Future<Map<int, Surah>> fetchSurah() async {
    return Quran.getSurahAsMap();
  }

  Future<List<String>> getSurahVerse(int surahNumber) async {
    int verseCount = quran.getVerseCount(surahNumber);
    List<String> verses = [];
    for (int i = 1; i <= verseCount; i++) {
      verses.add(quran.getVerse(surahNumber, i, verseEndSymbol: true));
    }
    return verses;
  }

  @override
  Future<String> getUrlAudio(int surahNumber) async {
    print(surahNumber);
    String url = await quran.getAudioURLBySurah(surahNumber);
    print(url);

    return url;
  }

  @override
  RandomVerse getRandoVerse() {
    RandomVerse randomVerse = RandomVerse();
    return randomVerse;
  }

  @override
  String getSurah(int surahName) {
    final String surah = getSurahName(surahName);
    return surah;
  }

  @override
  String getSurahName(int surahNumber) {
    final result = quran.getSurahName(surahNumber);
    return result;
  }
}
