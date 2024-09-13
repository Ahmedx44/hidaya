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
              final successState = state as SurahListLoaded;
              return ListView.builder(
                itemCount: successState.surhas.length,
                itemBuilder: (context, index) {
                  final surah = successState.surhas[index + 1];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Theme.of(context).colorScheme.onTertiary,
                    child: ListTile(
                      title: Row(
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
                          const SizedBox(
                            width: 150,
                          ),
                          Column(
                            children: [
                              Text(
                                surah?.name ?? 'Unkown',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Text(
                                surah?.nameEnglish ?? 'Unkown',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      ),
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
