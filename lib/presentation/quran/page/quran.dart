import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          title: Text(widget.surah.nameEnglish),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: 500,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: _showAllVerses(surahVerse, context),
            ),
          ),
        ));
  }
}

Widget _showAllVerses(List<Verse> surah, BuildContext context) {
  String joinedVerses = surah
      .asMap()
      .map((index, verse) => MapEntry(
          index, "${verse.text}" + quran.getVerseEndSymbol(verse.verseNumber)))
      .values
      .join();

  return Text(
    joinedVerses,
    textAlign: TextAlign.justify,
    style: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary, fontSize: 25),
  );
}
