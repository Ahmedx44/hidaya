import 'package:hydrated_bloc/hydrated_bloc.dart';

class SurahCubit extends HydratedCubit<int> {
  SurahCubit() : super(1); // Initial state is 1

  void setSurahNumber(int surahNumber) {
    emit(surahNumber);
  }

  @override
  Map<String, dynamic>? toJson(int state) {
    return {'surahNumber': state};
  }

  @override
  int fromJson(Map<String, dynamic>? json) {
    return json?['surahNumber'] ?? 1; // Default to 1 if no value
  }
}
