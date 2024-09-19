import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final hadiths = getHadiths(collection, bookNum);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(hadithBook),
      ),
      body: ListView.builder(
        itemCount: hadiths.length,
        itemBuilder: (context, index) {
          final hadithBook = hadiths[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '(${hadithBook.hadith[0].chapterNumber}) Chapter: ${hadithBook.hadith[0].chapterTitle}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        hadithBook.hadith[0].body
                            .replaceAll('</p>', '')
                            .replaceAll('<p>', ''),
                        style: GoogleFonts.amiri(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.8,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        hadithBook.hadith[1].body
                            .replaceAll('</p>', '')
                            .replaceAll('<p>', ''),
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          height: 1.3,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 32,
                  thickness: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
