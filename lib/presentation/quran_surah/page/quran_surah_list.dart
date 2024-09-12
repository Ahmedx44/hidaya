import 'package:flutter/material.dart';
import 'package:quran_flutter/models/surah.dart';
import 'package:quran_flutter/quran.dart';

class QuranSurahList extends StatefulWidget {
  const QuranSurahList({super.key});

  @override
  State<QuranSurahList> createState() => _QuranSurahListState();
}

class _QuranSurahListState extends State<QuranSurahList> {
  Map<int, Surah> result = {};

  @override
  void initState() {
    super.initState();
    result = Quran.getSurahAsMap(); // Corrected assignment
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surahs List'),
      ),
      body: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          final surah = result[index + 1];
          return ListTile(
            title: Row(
              children: [
                Text('${index + 1}:'),
                Text(surah?.name ?? 'Unknown'),
              ],
            ),
          );
        },
      ),
    );
  }
}
