import 'package:hidaya/data/model/prayer/prayerModel.dart';
import 'package:hidaya/domain/respository/prayer/prayer_repository.dart';

class PrayerRepositoryImpl extends PrayerRepository {
  @override
  Future<PrayerModel> getPrayerTimes() async {
    // Fetch prayer times from API or local data
    return PrayerModel(
      fajr: DateTime.parse("2024-09-20 04:41:00"),
      dhuhr: DateTime.parse("2024-09-20 12:30:00"),
      asr: DateTime.parse("2024-09-20 15:45:00"),
      maghrib: DateTime.parse("2024-09-20 18:30:00"),
      isha: DateTime.parse("2024-09-20 20:00:00"),
    );
  }
}
