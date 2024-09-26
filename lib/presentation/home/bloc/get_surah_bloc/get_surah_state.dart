class GetSurahState {}

class GetSurahLoading extends GetSurahState {}

class GetSurahLoaded extends GetSurahState {
  final String surah;

  GetSurahLoaded({required this.surah});
}

class GetSurahError extends GetSurahState {}

class GetSurahInitial extends GetSurahState {}
