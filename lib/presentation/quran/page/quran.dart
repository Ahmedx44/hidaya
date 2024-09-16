import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';
import 'package:hidaya/domain/usecase/quran/allverse_useCase.dart';
import 'package:hidaya/presentation/quran/Bloc/quran_page_cubit.dart';
import 'package:hidaya/presentation/quran/Bloc/quran_page_state.dart';
import 'package:hidaya/service_locator.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran_flutter/quran_flutter.dart';

class QuranPage extends StatefulWidget {
  final int surahNumber;
  final Surah surah;
  const QuranPage({super.key, required this.surahNumber, required this.surah});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranPageCubit(sl<AllverseUsecase>())
        ..fetchQuranVerse(widget.surahNumber),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(widget.surah.nameEnglish),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: BlocBuilder<QuranPageCubit, QuranPageState>(
            builder: (context, state) {
              if (state is QuranPageLoaded) {
                var sucessState = state as QuranPageLoaded;
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Row(
                              children: [
                                Icon(
                                  Icons.play_arrow,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Play Audio',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SvgPicture.asset(
                          height: 50,
                          Appvector.bismillah,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _showAllVerses(sucessState.verse, context),
                        // Container(
                        //   child: Column(
                        //     children: sucessState.verse
                        //         .map((e) => Text(e.text))
                        //         .toList(),
                        //   ),
                        // )
                      ]),
                    ),
                  ),
                );
              } else
                return SizedBox();
            },
          )),
    );
  }
}

Widget _showAllVerses(List<Verse> surah, BuildContext context) {
  String joinedVerses = surah
      .asMap()
      .map((index, verse) => MapEntry(
          index,
          "${verse.text}${quran.getVerseEndSymbol(
            verse.verseNumber,
            arabicNumeral: true,
          )}"))
      .values
      .join();

  return Text(joinedVerses,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      style: ArabicTextStyle(
          arabicFont: ArabicFont.scheherazade,
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 36,
          wordSpacing: -6,
          fontWeight: FontWeight.w500,
          letterSpacing: -1.1));
}
