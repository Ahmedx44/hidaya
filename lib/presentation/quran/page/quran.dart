import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
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
  late List<Verse> surahVerse;

  List<Verse> getSurahVerse() {
    return Quran.getSurahVersesAsList(widget.surahNumber);
  }

  @override
  void initState() {
    super.initState();
    surahVerse = getSurahVerse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: _showAllVerses(surahVerse, context),
        ),
      ),
    );
  }
}

Widget _showAllVerses(List<Verse> surah, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: surah
        .asMap()
        .map((index, verse) {
          return MapEntry(
            index,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      verse.text,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Uthmanic',
                        height: 1.5,
                      ),
                    ),
                  ),
                  Icon(FlutterIslamicIcons.allah,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      size: 24), // Icon after each verse
                ],
              ),
            ),
          );
        })
        .values
        .toList(),
  );
}
