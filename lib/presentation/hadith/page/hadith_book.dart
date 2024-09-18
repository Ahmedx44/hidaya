import 'package:flutter/material.dart';
import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';

class HadithBook extends StatelessWidget {
  final Collections collection;
  final String bookNumber;
  final String hadithBook;

  const HadithBook(
      {super.key,
      required this.collection,
      required this.bookNumber,
      required this.hadithBook});

  @override
  Widget build(BuildContext context) {
    int bookNum = int.parse(bookNumber);
    final hadiths = getHadiths(
        collection, bookNum); // Assuming this returns a list of Hadith

    return Scaffold(
      appBar: AppBar(
        title: Text(hadithBook),
      ),
      body: ListView.builder(
        itemCount: hadiths.length,
        itemBuilder: (context, index) {
          final hadithBook = hadiths[index];
          print('hellooo ${hadithBook}');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Container(
                  child: Column(
                    children: [
                      Text(
                        '(${hadithBook.hadith[0].chapterNumber})Chapter: ${hadithBook.hadith[0].chapterTitle}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(hadithBook.hadith[1].body
                          .replaceAll('</p>', '')
                          .replaceAll('<p>', '')),
                      Text(hadithBook.hadith[0].body
                          .replaceAll('</p>', '')
                          .replaceAll('<p>', ''))
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
