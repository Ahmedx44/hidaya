import 'package:quran_flutter/models/surah.dart';

abstract class SurahSearchState {}

class SurahSearchInitial extends SurahSearchState {}

class SurahSearchLoading extends SurahSearchState {}

class SurahSearchLoaded extends SurahSearchState {
  final Map<int, Surah> surahList;
  SurahSearchLoaded(this.surahList);
}

class SurahSearchError extends SurahSearchState {}
