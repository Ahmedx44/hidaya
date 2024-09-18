import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/data/source/quran/quran_service.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/audio_plaer_bloc/audio_player_state.dart';
import 'package:hidaya/service_locator.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  AudioPlayerCubit() : super(AudioPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
      updateSongPlayer();
    });
  }

  void updateSongPlayer() {
    emit(AudioPlayerLoaded());
  }

  Future<void> loadSong(int surahNumber) async {
    try {
      emit(AudioPlayerLoading());
      print(surahNumber);
      String url = await sl<QuranService>().getUrlAudio(surahNumber);
      print(url);
      audioPlayer.setUrl(url);
      emit(AudioPlayerLoading());
    } catch (e) {
      emit(AudioPlayerErro());
    }
  }

  void pladOrPauseSOng() {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }
    emit(AudioPlayerLoaded());
  }

  void perviousAudio() {
    audioPlayer.seekToPrevious();
  }

  void nextAudio() {
    audioPlayer.seekToNext();
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
