import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/quran/surah_usecase.dart';
import 'package:hidaya/presentation/quran/page/quran.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/quran_list_cubit.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/quran_list_state.dart';
import 'package:hidaya/service_locator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;

class QuranSurahList extends StatefulWidget {
  const QuranSurahList({super.key});

  @override
  State<QuranSurahList> createState() => _QuranSurahListState();
}

class _QuranSurahListState extends State<QuranSurahList> {
  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
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
                                surahNumber: index + 1, surah: surah!);
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
                              onTap: () async {
                                bool isPlaying = true;
                                String url =
                                    quran.getAudioURLBySurah(surah!.number);
                                print(url);

                                final audioSource =
                                    LockCachingAudioSource(Uri.parse(url));
                                await player.setAudioSource(audioSource);

                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          Slider(
                                              value: 2,
                                              min: 0.0,
                                              max: 10.0,
                                              onChanged: (double val) {}),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                  icon: const Icon(
                                                      Icons.fast_rewind,
                                                      size: 50),
                                                  onPressed: () {
                                                    // Handle rewind action
                                                  }),
                                              IconButton(
                                                icon: isPlaying
                                                    ? const Icon(
                                                        Icons
                                                            .pause_circle_filled_outlined,
                                                        size: 50)
                                                    : const Icon(
                                                        Icons
                                                            .play_circle_fill_rounded,
                                                        size: 50),
                                                onPressed: () {
                                                  setState(() async {
                                                    if (isPlaying) {
                                                      await player.play();
                                                    } else {
                                                      await player.pause();
                                                    }
                                                    isPlaying = !isPlaying;
                                                  });
                                                },
                                              ),
                                              IconButton(
                                                  icon: const Icon(
                                                      Icons.fast_forward,
                                                      size: 50),
                                                  onPressed: () {
                                                    // Handle forward action
                                                  }),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.play_circle_fill_outlined,
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
}
