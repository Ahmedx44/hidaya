import 'package:cloud_firestore/cloud_firestore.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final DocumentReference<Map<String, dynamic>> user;

  EditProfileLoaded({required this.user});
}

class EditProfileError extends EditProfileState {}
