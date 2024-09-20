import 'package:quran_flutter/models/surah.dart';

class SearchState {}

class SearchStateIntital extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateLoaded extends SearchState {
  final Map<int, Surah> surahMap;

  SearchStateLoaded({required this.surahMap});
}

class SearchStateError extends SearchState {}
