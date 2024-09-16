import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';
import 'package:quran_flutter/models/surah.dart';
import 'package:quran_flutter/models/verse.dart';
import 'package:quran_flutter/quran.dart';
import 'package:quran/quran.dart' as quran;

class QuranPage extends StatefulWidget {
  final int surahNumber;
  final Surah surah;
  const QuranPage({super.key, required this.surahNumber, required this.surah});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  var surahVerse;

  List<Verse> getSurahverse() {
    final result = Quran.getSurahVersesAsList(
      widget.surahNumber,
    );
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final quran = getSurahverse();
    print(quran[widget.surahNumber].text);
    surahVerse = quran;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.surah.nameEnglish),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                              color: Theme.of(context).colorScheme.primary,
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
                _showAllVerses(surahVerse, context),
              ]),
            ),
          ),
        ));
  }
}

Widget _showAllVerses(List<Verse> surah, BuildContext context) {
  String joinedVerses = surah
      .asMap()
      .map((index, verse) => MapEntry(
          index, "${verse.text}${quran.getVerseEndSymbol(verse.verseNumber)}"))
      .values
      .join();

  return Text(joinedVerses,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      style: ArabicTextStyle(
          arabicFont: ArabicFont.scheherazade,
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 26,
          wordSpacing: -1,
          letterSpacing: -0.5));
}
