import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/user/get_userName_useCase.dart';
import 'package:hidaya/presentation/home/bloc/get_user_bloc/get_username_state.dart';

class GetUsernameCubit extends Cubit<GetUsernameState> {
  GetUsernameUsecase getUsernameUsecase;
  GetUsernameCubit(this.getUsernameUsecase) : super(GetUsernameInitial());

  getUserName() {
    emit(GetUsernameLoading());
    final result = getUsernameUsecase();
    emit(GetUsernameLoaded(user: result));
  }
}
