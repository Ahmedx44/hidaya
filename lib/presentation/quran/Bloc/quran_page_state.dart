abstract class QuranPageState {}

class QuranPageIntitial extends QuranPageState {}

class QuranPageLoading extends QuranPageState {}

class QuranPageLoaded extends QuranPageState {
  final List verse;

  QuranPageLoaded({required this.verse});
}

class QuranPageError extends QuranPageState {}
