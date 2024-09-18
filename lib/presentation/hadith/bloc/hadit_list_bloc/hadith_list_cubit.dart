import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/classes.dart';
import 'package:hidaya/domain/usecase/hadith/get_collection.dart';
import 'package:hidaya/presentation/hadith/bloc/hadit_list_bloc/hadith_list_state.dart';

class HadithListCubit extends Cubit<HadithListState> {
  GetCollectionUseCase getCollectionUseCase;

  HadithListCubit(this.getCollectionUseCase) : super(HadithListInitial());

  void getCollections() {
    emit(HadithListLoadind());
    List<Collection> collection = getCollectionUseCase();
    emit(HadithListLoaded(collection: collection));
  }
}
