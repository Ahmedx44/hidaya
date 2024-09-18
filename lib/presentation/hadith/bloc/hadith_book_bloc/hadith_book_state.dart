import 'package:hadith/classes.dart';

abstract class HadithBookState {}

class HadithBookIntital extends HadithBookState {}

class HadithBookLoading extends HadithBookState {}

class HadithBookLoaded extends HadithBookState {
  final List<Book> collection;

  HadithBookLoaded({required this.collection});
}

class HadithBookError extends HadithBookState {}
