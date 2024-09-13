import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/surah/surah_usecase.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/quran_list_cubit.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/quran_list_state.dart';
import 'package:hidaya/service_locator.dart';

class QuranSurahList extends StatelessWidget {
  const QuranSurahList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurahListCubit(sl<SurahUsecase>())..fetchSurah(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Surahs List'),
        ),
        body: BlocBuilder<SurahListCubit, SurahListState>(
          builder: (context, state) {
            if (state is SurahListLoaded) {
              final successState = state as SurahListLoaded;
              return ListView.builder(
                itemCount: successState.surhas.length,
                itemBuilder: (context, index) {
                  final surah = successState.surhas[index + 1];

                  return ListTile(
                    title: Row(
                      children: [
                        Text('${index + 1}:'),
                        Text(surah?.name ?? 'Unkown'),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
