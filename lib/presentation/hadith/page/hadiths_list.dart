import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';
import 'package:hidaya/domain/usecase/hadith/get_collection.dart';
import 'package:hidaya/presentation/hadith/bloc/hadith_list/hadith_list_cubit.dart';
import 'package:hidaya/presentation/hadith/bloc/hadith_list/hadith_list_state.dart';
import 'package:hidaya/presentation/hadith/page/hadith_books_list.dart';
import 'package:hidaya/service_locator.dart';

class HadithsList extends StatelessWidget {
  const HadithsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HadithListCubit(sl<GetCollectionUseCase>())..getCollections(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Hadiths',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).colorScheme.inversePrimary),
          ),
        ),
        body: BlocBuilder<HadithListCubit, HadithListState>(
          builder: (context, state) {
            if (state is HadithListLoadind) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HadithListLoaded) {
              final successState = state as HadithListLoaded;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: successState.collection.length,
                      itemBuilder: (context, index) {
                        Collection hadith = successState.collection[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).colorScheme.onTertiary),
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  late Collections collections =
                                      Collections.abudawud;

                                  if (hadith.name == 'tirmidhi') {
                                    collections = Collections.tirmidhi;
                                  } else if (hadith.name == 'abudawud') {
                                    collections = Collections.abudawud;
                                  } else if (hadith.name == 'bukhari') {
                                    collections = Collections.bukhari;
                                  } else if (hadith.name == 'ibnmajah') {
                                    collections = Collections.ibnmajah;
                                  } else if (hadith.name == 'nasai') {
                                    collections = Collections.nasai;
                                  } else if (hadith.name == 'muslim') {
                                    collections = Collections.muslim;
                                  }

                                  return HadithBooksList(
                                    collection: collections,
                                  );
                                },
                              ));
                            },
                            child: ListTile(
                              subtitle: Row(
                                children: [
                                  Text(
                                    'Hadiths:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(hadith.totalAvailableHadith.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inversePrimary,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              title: Text(
                                '${hadith.name[0].toUpperCase()}${hadith.name.substring(1)}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return Text('There is an Error');
            }
          },
        ),
      ),
    );
  }
}
