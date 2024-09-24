import 'package:firebase_auth/firebase_auth.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final User user;

  EditProfileLoaded({required this.user});
}

class EditProfileError extends EditProfileState {}
