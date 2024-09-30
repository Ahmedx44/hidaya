import 'package:arabic_font/arabic_font.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';
import 'package:hidaya/domain/usecase/quran/get_page_model.dart';
import 'package:hidaya/presentation/quran/Bloc/quran_page_cubit.dart';
import 'package:hidaya/presentation/quran/Bloc/quran_page_state.dart';
import 'package:hidaya/service_locator.dart';

class QuranPage extends StatefulWidget {
  final int surahNumber;
  const QuranPage({super.key, required this.surahNumber});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _updateHeatmap();
  }

  Future<void> _updateHeatmap() async {
    final userDoc = _firestore.collection('User').doc(userId);
    final today = DateTime.now();
    final todayDate = "${today.year}-${today.month}-${today.day}";

    // Retrieve the user document snapshot
    DocumentSnapshot<Map<String, dynamic>> userData = await userDoc.get();

    // Check if the document exists and if the 'heatmap' field exists
    if (userData.exists) {
      List<Map<String, dynamic>> heatmap =
          List<Map<String, dynamic>>.from(userData.data()?['heatmap'] ?? []);

      // Update the heatmap list
      bool dateExists = false;
      for (var entry in heatmap) {
        if (entry['date'] == todayDate) {
          entry['count'] += 1;
          dateExists = true;
          break;
        }
      }

      if (!dateExists) {
        heatmap.add({"date": todayDate, "count": 1});
      }

      await userDoc.update({"heatmap": heatmap});
    } else {
      // If the document doesn't exist or the 'heatmap' field is missing, create a new entry
      await userDoc.set({
        "heatmap": [
          {"date": todayDate, "count": 1}
        ]
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranPageCubit(sl<GetPageDataUseCase>())
        ..getSurahVerse(widget.surahNumber),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Quran Surahs'),
        ),
        body: BlocBuilder<QuranPageCubit, QuranPageState>(
          builder: (context, state) {
            if (state is QuranPageLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            } else if (state is QuranPageError) {
              return const Center(
                child: Text('Error'),
              );
            } else if (state is QuranPageLoaded) {
              final successState = state as QuranPageLoaded;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      height: 50,
                      Appvector.bismillah,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    RichText(
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        style: ArabicTextStyle(
                          arabicFont: ArabicFont.scheherazade,
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        children: successState.verse.map((verse) {
                          return TextSpan(
                            text: verse + '',
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
