import 'package:cloud_firestore/cloud_firestore.dart';

class GetUsernameState {}

class GetUsernameLoading extends GetUsernameState {}

class GetUsernameLoaded extends GetUsernameState {
  final Future<DocumentSnapshot<Map<String, dynamic>>> user;

  GetUsernameLoaded({required this.user});
}

class GetUsernameError extends GetUsernameState {}

class GetUsernameInitial extends GetUsernameState {}
