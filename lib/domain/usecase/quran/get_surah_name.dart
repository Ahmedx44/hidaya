import 'package:hidaya/data/source/quran/quran_service.dart';
import 'package:hidaya/service_locator.dart';

class GetSurahNameUseCase {
  String call(params) {
    return sl<QuranService>().getSurahName(params);
  }
}
