import 'package:hidaya/domain/respository/quran/surah_reposiotry.dart';
import 'package:hidaya/service_locator.dart';
import 'package:quran_flutter/models/surah.dart';

class SurahUsecase {
  Future<Map<int, Surah>> call() async {
    return sl<SurahReposiotry>().getSurahAsMap();
  }
}
