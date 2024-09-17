import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';
import 'package:hidaya/domain/usecase/quran/get_page_model.dart';
import 'package:hidaya/presentation/quran/Bloc/quran_page_cubit.dart';
import 'package:hidaya/presentation/quran/Bloc/quran_page_state.dart';
import 'package:hidaya/service_locator.dart';

class QuranPage extends StatelessWidget {
  final int surahNumber;
  const QuranPage({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QuranPageCubit(sl<GetPageDataUseCase>())..getSurahVerse(surahNumber),
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

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SvgPicture.asset(height: 50, Appvector.bismillah),
                    RichText(
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        style: const ArabicTextStyle(
                          arabicFont: ArabicFont.scheherazade,
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        children: successState.verse.map((verse) {
                          return TextSpan(
                            text: verse + '',
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
