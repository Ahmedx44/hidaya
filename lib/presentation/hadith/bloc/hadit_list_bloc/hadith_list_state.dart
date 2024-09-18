import 'package:hadith/classes.dart';

abstract class HadithListState {}

class HadithListInitial extends HadithListState {}

class HadithListLoadind extends HadithListState {}

class HadithListLoaded extends HadithListState {
  final List<Collection> collection;

  HadithListLoaded({required this.collection});
}

class HadithListError extends HadithListState {}
