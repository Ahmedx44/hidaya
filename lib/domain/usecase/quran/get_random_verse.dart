import 'package:hidaya/data/source/quran/quran_service.dart';
import 'package:hidaya/service_locator.dart';
import 'package:quran/quran.dart';

class GetRandomVerseUseCase {
  RandomVerse call() {
    return sl<QuranService>().getRandoVerse();
  }
}
