import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidaya/domain/usecase/quran/surah_search_usecase.dart';
import 'package:hidaya/presentation/search/bloc/search_cubit.dart';
import 'package:hidaya/presentation/search/bloc/search_state.dart';
import 'package:hidaya/service_locator.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurahSearchCubit(sl<SurahSearchUsecase>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search Surah"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search surah',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                ),
                onChanged: (query) {
                  // Trigger Cubit's search logic only when the query changes
                  context.read<SurahSearchCubit>().searchSurah(query);
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<SurahSearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchStateLoading) {
                    // Show a loading indicator while searching
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchStateLoaded) {
                    final surahMap = state.surahMap;

                    // If no results, show a message
                    if (surahMap.isEmpty) {
                      return const Center(child: Text("No Surah found"));
                    }

                    // Display the list of Surahs
                    return ListView.builder(
                      itemCount: surahMap.length,
                      itemBuilder: (context, index) {
                        final surah = surahMap.values.elementAt(index);
                        return ListTile(
                          title: Text(surah.name),
                          subtitle: Text('Surah number: ${surah.number}'),
                        );
                      },
                    );
                  } else if (state is SearchStateIntital) {
                    // Display a message to prompt the user to start searching
                    return const Center(child: Text("Start searching..."));
                  } else {
                    // Handle other states
                    return const Center(child: Text("An error occurred"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
