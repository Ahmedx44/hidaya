import 'package:hadith/classes.dart';

abstract class HadithBookState {}

class HadithBookInitial extends HadithBookState {}

class HadithBookLoading extends HadithBookState {}

class HadithBookLoaded extends HadithBookState {
  final List<Hadith> hadiths;

  HadithBookLoaded({required this.hadiths});
}

class HadithBookError extends HadithBookState {}
