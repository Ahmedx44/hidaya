import 'package:hadith/classes.dart';

abstract class HadithListBookState {}

class HadithListBookIntital extends HadithListBookState {}

class HadithListBookLoading extends HadithListBookState {}

class HadithListBookLoaded extends HadithListBookState {
  final List<Book> collection;

  HadithListBookLoaded({required this.collection});
}

class HadithListBookError extends HadithListBookState {}
