import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/quran/surah_usecase.dart';
import 'package:hidaya/presentation/quran/page/quran.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/quran_list_cubit.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/quran_list_state.dart';
import 'package:hidaya/presentation/quran_surah_list/widget/audio_player.dart';
import 'package:hidaya/service_locator.dart';
import 'package:just_audio/just_audio.dart';

class QuranSurahList extends StatefulWidget {
  const QuranSurahList({super.key});

  @override
  State<QuranSurahList> createState() => _QuranSurahListState();
}

class _QuranSurahListState extends State<QuranSurahList> {
  bool isPlaying = false;
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurahListCubit(sl<SurahUsecase>())..fetchSurah(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Surahs List',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<SurahListCubit, SurahListState>(
          builder: (context, state) {
            if (state is SurahListLoaded) {
              final successState = state;
              return ListView.builder(
                itemCount: successState.surhas.length,
                itemBuilder: (context, index) {
                  final surah = successState.surhas[index + 1];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Theme.of(context).colorScheme.onTertiary,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return QuranPage(
                              surahNumber: surah!.number,
                            );
                          },
                        ));
                      },
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${index + 1}:',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary),
                            ),
                            Column(
                              children: [
                                Text(
                                  surah?.name ?? 'Unknown',
                                  style: ArabicTextStyle(
                                      arabicFont: ArabicFont.scheherazade,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  surah?.nameEnglish ?? 'Unknown',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return QuranAudio(
                                      isPlaying: true,
                                      surahNumber: surah!.number,
                                    );
                                  },
                                ));
                              },
                              child: Icon(
                                Icons.play_circle_fill_outlined,
                                color: Theme.of(context).colorScheme.primary,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  // Formatting duration to show as mm:ss
  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
