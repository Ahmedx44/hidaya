import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/audio_plaer_bloc/audio_player_cubit.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/audio_plaer_bloc/audio_player_state.dart';

class QuranAudio extends StatelessWidget {
  final bool isPlaying = false;
  final int surahNumber;
  const QuranAudio({super.key, required this.surahNumber});

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
                    // Center the Image
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(40),
                        height: 300,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onTertiary,
                          borderRadius: BorderRadius.circular(12), // Optional
                        ),
                        child: SvgPicture.asset(
                          Appvector.quran,
                          fit: BoxFit.contain,
                        ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.arrow_circle_left,
                          size: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<AudioPlayerCubit>().pladOrPauseSOng();
                          },
                          child: Icon(
                            Icons.play_circle_fill,
                            size: 50,
                          ),
                        ),
                        Icon(
                          Icons.arrow_circle_right,
                          size: 50,
                        )
                      ],
                    )
                  ],
                );
              } else {
                return Center(
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
