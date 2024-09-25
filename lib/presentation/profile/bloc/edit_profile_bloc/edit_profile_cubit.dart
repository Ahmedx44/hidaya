import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/user/get_user_usecase.dart';
import 'package:hidaya/presentation/profile/bloc/edit_profile_bloc/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  GetUserUsecase getUserUsecase;

  EditProfileCubit(this.getUserUsecase) : super(EditProfileInitial());

  getUser() async {
    emit(EditProfileLoading());
    final result = await getUserUsecase();
    emit(EditProfileLoaded(user: result));
  }
}
