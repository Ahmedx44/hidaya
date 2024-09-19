import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hadith/hadith.dart';
import 'package:hidaya/domain/usecase/hadith/get_hadith.dart';
import 'package:hidaya/presentation/hadith/bloc/hadith_book_bloc/hadith_book_cubit.dart';
import 'package:hidaya/presentation/hadith/bloc/hadith_book_bloc/hadith_book_state.dart';
import 'package:hidaya/service_locator.dart';

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

    return BlocProvider(
      create: (context) => HadithBookCubit(sl<GetHadithUseCase>())
        ..loadHadith(collection, bookNum),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(hadithBook),
        ),
        body: BlocBuilder<HadithBookCubit, HadithBookState>(
          builder: (context, state) {
            if (state is HadithBookLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HadithBookLoaded) {
              return Expanded(
                child: ListView.builder(
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
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
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
