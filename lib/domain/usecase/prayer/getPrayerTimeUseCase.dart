import 'package:hidaya/data/model/prayer/prayerModel.dart';
import 'package:hidaya/domain/respository/prayer/prayer_repository.dart';

class GetPrayerTimeUseCase {
  final PrayerRepository repository;

  GetPrayerTimeUseCase(this.repository);

  Future<String> getTimeUntilNextPrayer(DateTime currentTime) async {
    PrayerModel prayerTime = await repository.getPrayerTimes();

    DateTime? nextPrayer;
    if (currentTime.isBefore(prayerTime.fajr)) {
      nextPrayer = prayerTime.fajr;
    } else if (currentTime.isBefore(prayerTime.dhuhr)) {
      nextPrayer = prayerTime.dhuhr;
    } else if (currentTime.isBefore(prayerTime.asr)) {
      nextPrayer = prayerTime.asr;
    } else if (currentTime.isBefore(prayerTime.maghrib)) {
      nextPrayer = prayerTime.maghrib;
    } else if (currentTime.isBefore(prayerTime.isha)) {
      nextPrayer = prayerTime.isha;
    }

    if (nextPrayer != null) {
      final difference = nextPrayer.difference(currentTime);
      return "${difference.inHours} hours ${difference.inMinutes % 60} minutes left";
    } else {
      return "No upcoming prayer today";
    }
  }
}
