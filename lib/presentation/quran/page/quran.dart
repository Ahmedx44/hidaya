import 'package:flutter/material.dart';
import 'package:quran_flutter/enums/quran_language.dart';
import 'package:quran_flutter/models/verse.dart';
import 'package:quran_flutter/quran.dart';

class QuranPage extends StatefulWidget {
  final int surahNumber;
  const QuranPage({super.key, required this.surahNumber});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  var surahVerse;

  List<Verse> getSurahverse() {
    final result = Quran.getSurahVersesAsList(widget.surahNumber,
        language: QuranLanguage.amharic);
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
        body: Center(
      child: Text(surahVerse[1].text),
    ));
  }
}
