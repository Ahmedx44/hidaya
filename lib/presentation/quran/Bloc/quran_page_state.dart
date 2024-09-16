import 'package:quran_flutter/models/verse.dart';

abstract class QuranPageState {}

class QuranPageIntitial extends QuranPageState {}

class QuranPageLoading extends QuranPageState {}

class QuranPageLoaded extends QuranPageState {
  final List<Verse> verse;

  QuranPageLoaded({required this.verse});
}
