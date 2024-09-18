import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/hadith.dart';
import 'package:hidaya/domain/usecase/hadith/get_books.dart';
import 'package:hidaya/presentation/hadith/bloc/hadith_book_bloc/hadith_book_cubit.dart';
import 'package:hidaya/presentation/hadith/bloc/hadith_book_bloc/hadith_book_state.dart';
import 'package:hidaya/presentation/hadith/page/hadith_book.dart';
import 'package:hidaya/service_locator.dart';

class HadithBooksList extends StatelessWidget {
  final Collections collection;
  const HadithBooksList({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HadithBookCubit(sl<GetBooksUseCase>())..getBooks(collection),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hadith Books'),
        ),
        body: BlocBuilder<HadithBookCubit, HadithBookState>(
          builder: (context, state) {
            if (state is HadithBookLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HadithBookLoaded) {
              final successState = state as HadithBookLoaded;

              return ListView.builder(
                itemCount: successState.collection.length,
                itemBuilder: (context, index) {
                  final book = successState.collection[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.tertiary),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return HadithBook(
                              hadithBook: book.book[0].name,
                              bookNumber: book.bookNumber,
                              collection: collection,
                            );
                          },
                        ));
                      },
                      child: ListTile(
                        leading: Text(book.bookNumber,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        title: Text(book.book[0].name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Row(
                          children: [
                            Text('Hadith start: ${book.hadithStartNumber}'),
                            const SizedBox(
                              width: 20,
                            ),
                            Text('Hadith start: ${book.hadithEndNumber}')
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No books found'),
              );
            }
          },
        ),
      ),
    );
  }
}
