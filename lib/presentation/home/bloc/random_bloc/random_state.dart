import 'package:quran/quran.dart';

abstract class RandomState {}

class RandomStateInitial extends RandomState {}

class RandomStateLoading extends RandomState {}

class RandomStateLoaded extends RandomState {
  final RandomVerse randomVerse;

  RandomStateLoaded({required this.randomVerse});
}

class RandomStateError extends RandomState {}
