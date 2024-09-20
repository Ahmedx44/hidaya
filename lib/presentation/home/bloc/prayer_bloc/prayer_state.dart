abstract class PrayerState {}

class PrayerInitial extends PrayerState {}

class PrayerLoading extends PrayerState {}

class PrayerLoaded extends PrayerState {
  final String timeLeft;
  PrayerLoaded(this.timeLeft);
}

class PrayerError extends PrayerState {}
