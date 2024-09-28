import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/user/follow_user_usecase.dart';
import 'package:hidaya/presentation/profile/bloc/user_profile_bloc/user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final FollowUserUsecase followUserUsecase;
  UserProfileCubit(this.followUserUsecase) : super(UserProfileInitial());

  Future<void> followUser(String email) async {
    emit(UserProfileLoading());
    print('Follow button pressed'); // Add this line
    final result = await followUserUsecase(email);
    if (result == 'Followed') {
      emit(UserProfileSuccess());
    } else {
      emit(UserProfieError()); // Make sure you handle the error state here
    }
  }

  Future<void> unfollowUser(String email) async {}
}
