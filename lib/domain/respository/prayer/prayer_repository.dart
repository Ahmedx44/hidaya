import 'package:hidaya/data/model/prayer/prayerModel.dart';

abstract class PrayerRepository {
  Future<PrayerModel> getPrayerTimes();
}
