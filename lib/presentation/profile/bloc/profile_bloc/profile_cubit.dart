import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hidaya/domain/usecase/user/get_user_data_usecase.dart';
import 'package:hidaya/presentation/profile/bloc/profile_bloc/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserDataUsecase getUserUsecase;

  ProfileCubit(this.getUserUsecase) : super(ProfileStateInitial());

  void getUser() {
    emit(ProfileStateLoading());
    final result = getUserUsecase();
    emit(ProfileStateLoaded(user: result));
  }
}
