import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/quran/get_page_model.dart';
import 'package:hidaya/presentation/quran/Bloc/quran_page_cubit.dart';
import 'package:hidaya/presentation/quran/Bloc/quran_page_state.dart';
import 'package:hidaya/service_locator.dart';

class QuranPage extends StatelessWidget {
  final List<int> surahPage;
  const QuranPage({super.key, required this.surahPage});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QuranPageCubit(sl<GetPageDataUseCase>())..loadQuranPage(surahPage[0]),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quran Surahs'),
        ),
        body: BlocBuilder<QuranPageCubit, QuranPageState>(
          builder: (context, state) {
            if (state is QuranPageLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else if (state is QuranPageError) {
              return const Center(
                child: Text('Error'),
              );
            } else if (state is QuranPageLoaded) {
              final successState = state as QuranPageLoaded;
              print(successState.verse);

              // Join all verses into a single string
              final allVerses = successState.verse.join('');

              print(surahPage[0]);
              if (surahPage[0] == 1 || surahPage[0] == 2) {
                return Center(
                  child: Container(
                    width: 250,
                    child: Text(
                      maxLines: 7,
                      allVerses,
                      textAlign: TextAlign.center,
                      style: const ArabicTextStyle(
                        arabicFont: ArabicFont.scheherazade,
                        fontSize: 27,
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      allVerses,
                      textAlign: TextAlign.justify,
                      style: const ArabicTextStyle(
                        arabicFont: ArabicFont.scheherazade,
                        fontSize: 25,
                      ),
                    ),
                  ),
                );
              }
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
