import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/prayer/getPrayerTimeUseCase.dart';
import 'package:hidaya/presentation/home/bloc/prayer_bloc/prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final GetPrayerTimeUseCase getPrayerTimeUseCase;

  PrayerCubit(this.getPrayerTimeUseCase) : super(PrayerInitial());

  void loadPrayerTime() async {
    emit(PrayerLoading());
    try {
      final currentTime = DateTime.now();
      final timeLeft =
          await getPrayerTimeUseCase.getTimeUntilNextPrayer(currentTime);
      emit(PrayerLoaded(timeLeft));
    } catch (e) {
      emit(PrayerError());
    }
  }
}
