import 'package:quran_flutter/models/surah.dart';

abstract class SurahListState {}

class SurahListInitial extends SurahListState {}

class SurahListLoading extends SurahListState {}

class SurahListLoaded extends SurahListState {
  final Map<int, Surah> surhas;

  SurahListLoaded({required this.surhas});
}

class SurahListFailed extends SurahListState {}
