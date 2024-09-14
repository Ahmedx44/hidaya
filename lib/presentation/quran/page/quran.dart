import 'package:flutter/material.dart';
import 'package:quran_flutter/models/verse.dart';
import 'package:quran_flutter/quran.dart';
import 'package:quran/quran.dart' as quran;

class QuranPage extends StatefulWidget {
  final int surahNumber;
  const QuranPage({super.key, required this.surahNumber});

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
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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

  return Center(
    child: Text(
      joinedVerses,
      textAlign: TextAlign.center,
      softWrap: true,
      style: TextStyle(
        fontSize: 24,
        color: Theme.of(context).colorScheme.inversePrimary,
        fontWeight: FontWeight.bold,
        fontFamily: 'Uthmanic',
        height: 1.5,
      ),
    ),
  );
}
