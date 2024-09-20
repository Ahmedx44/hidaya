import 'package:hidaya/data/source/quran/quran_service.dart';
import 'package:hidaya/service_locator.dart';
import 'package:quran_flutter/models/surah.dart';

class SurahSearchUsecase {
  Future<Map<int, Surah>> call(String query) async {
    final surahMap = await sl<QuranService>().fetchSurah();

    // Filter the map entries based on the search query
    final filteredEntries = surahMap.entries.where((entry) {
      final surah = entry.value;
      print(surah.nameEnglish);
      return surah.nameEnglish.toLowerCase().contains(query.toLowerCase());
    });

    // Convert filtered entries back to a map
    return Map<int, Surah>.fromEntries(filteredEntries);
  }
}
