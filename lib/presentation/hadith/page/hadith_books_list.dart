import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/hadith.dart';
import 'package:hidaya/domain/usecase/hadith/get_books.dart';
import 'package:hidaya/presentation/hadith/bloc/hadit_list_book_bloc/hadith_book_list_cubit.dart';
import 'package:hidaya/presentation/hadith/bloc/hadit_list_book_bloc/hadith_book_list_state.dart';
import 'package:hidaya/presentation/hadith/page/hadith_book_hadith.dart';
import 'package:hidaya/service_locator.dart';

class HadithBooksList extends StatelessWidget {
  final Collections collection;
  const HadithBooksList({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HadithListBookCubit(sl<GetBooksUseCase>())..getBooks(collection),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Hadith Books'),
        ),
        body: BlocBuilder<HadithListBookCubit, HadithListBookState>(
          builder: (context, state) {
            if (state is HadithListBookLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HadithListBookLoaded) {
              final successState = state as HadithListBookLoaded;

              return ListView.builder(
                itemCount: successState.collection.length,
                itemBuilder: (context, index) {
                  final book = successState.collection[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        title: Text(book.book[0].name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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
