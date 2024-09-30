import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/audio_plaer_bloc/audio_player_cubit.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/audio_plaer_bloc/audio_player_state.dart';
import 'package:quran_flutter/models/surah.dart';

class QuranAudio extends StatelessWidget {
  final int surahNumber;
  final Surah surah;
  const QuranAudio({super.key, required this.surahNumber, required this.surah});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioPlayerCubit()..loadSong(surahNumber),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
            builder: (context, state) {
              if (state is AudioPlayerLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }
              if (state is AudioPlayerLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(40),
                      height: 300,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onTertiary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        Appvector.quran,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Slider(
                      inactiveColor: Colors.grey,
                      activeColor: Theme.of(context).colorScheme.primary,
                      max: context
                          .read<AudioPlayerCubit>()
                          .songDuration
                          .inSeconds
                          .toDouble(),
                      min: 0,
                      value: context
                          .read<AudioPlayerCubit>()
                          .songPosition
                          .inSeconds
                          .toDouble(),
                      onChanged: (value) {
                        // Add the logic to seek audio
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(surah.name,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary)),
                        Text(surah.nameEnglish,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<AudioPlayerCubit>().backward();
                          },
                          icon: const Icon(
                            Icons.arrow_circle_left,
                            size: 70,
                          ),
                        ),
                        IconButton(
                          color: Theme.of(context).colorScheme.primary,
                          icon: Icon(
                            context.watch<AudioPlayerCubit>().isPlaying
                                ? Icons.pause_circle
                                : Icons.play_circle,
                            size: 70,
                          ),
                          onPressed: () {
                            context.read<AudioPlayerCubit>().pladOrPauseSOng();
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<AudioPlayerCubit>().forward();
                          },
                          icon: Icon(
                            Icons.arrow_circle_right,
                            size: 70,
                          ),
                        )
                      ],
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text('Failed to load'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
