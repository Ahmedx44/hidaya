import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';
import 'package:hidaya/domain/usecase/quran/get_surah_name.dart';
import 'package:hidaya/presentation/home/bloc/get_surah_bloc/get_surah_cubit.dart';
import 'package:hidaya/presentation/home/bloc/get_surah_bloc/get_surah_state.dart';
import 'package:hidaya/presentation/quran/page/quran.dart';
import 'package:hidaya/presentation/quran_surah_list/Bloc/surah_state_cubit.dart';
import 'package:hidaya/service_locator.dart';

class HomeCard extends StatefulWidget {
  const HomeCard({super.key});

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurahCubit, int>(
      builder: (context, surahNumber) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: BlocProvider(
              create: (context) => GetSurahCubit(sl<GetSurahNameUseCase>())
                ..getSurah(surahNumber),
              child: BlocBuilder<GetSurahCubit, GetSurahState>(
                builder: (context, state) {
                  if (state is GetSurahLoaded) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return QuranPage(surahNumber: surahNumber);
                          },
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  child: Row(
                                    children: [
                                      Icon(
                                        FlutterIslamicIcons.quran,
                                        weight: 1.0,
                                        size: 35,
                                      ),
                                      Text(
                                        'Last Read',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SvgPicture.asset(
                                    height: 50, Appvector.bismillah)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      state.surah,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Ayah No: 1',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: SvgPicture.asset(
                                      height: 80, Appvector.quran),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Icon(Icons.bookmark),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container(); // or a loading indicator
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
