import 'package:hidaya/data/model/surah/verse_Model.dart';
import 'package:hidaya/domain/respository/quran/surah_reposiotry.dart';
import 'package:hidaya/service_locator.dart';
import 'package:quran_flutter/models/verse.dart';

class AllverseUsecase {
  Future<List<Verse>> call({VerseModel? params}) async {
    final verses =
        await sl<SurahReposiotry>().getQuranVerse(params!.surahNumber);
    return verses.cast<Verse>();
  }
}
