import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/user/get_user_data_usecase.dart';
import 'package:hidaya/domain/usecase/user/get_user_usecase.dart';
import 'package:hidaya/presentation/profile/bloc/profile_bloc/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  GetUserDataUsecase getUserDataUsecase;
  ProfileCubit(this.getUserDataUsecase) : super(ProfileStateInitial());

  getUser() {
    emit(ProfileStateLoading());
    final result = getUserDataUsecase();
    emit(ProfileStateLoaded(user: result));
  }
}
