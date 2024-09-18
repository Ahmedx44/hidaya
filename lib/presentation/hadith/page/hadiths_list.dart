import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadith/classes.dart';
import 'package:hidaya/domain/usecase/hadith/get_collection.dart';
import 'package:hidaya/presentation/hadith/bloc/hadit_list_bloc/hadith_list_cubit.dart';
import 'package:hidaya/presentation/hadith/bloc/hadit_list_bloc/hadith_list_state.dart';
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
        appBar: AppBar(),
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
                          child: ListTile(
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
