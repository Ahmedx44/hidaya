import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hidaya/domain/usecase/location/getLocation.dart';
import 'package:hidaya/domain/usecase/time/time_usecase.dart';
import 'package:hidaya/presentation/home/widget/features.dart';
import 'package:hidaya/presentation/home/widget/home_card.dart';
import 'package:hidaya/presentation/home/widget/my_drawer.dart';
import 'package:hidaya/presentation/home/widget/randomVerse.dart';
import 'package:hidaya/presentation/search/page/search.dart';
import 'package:hidaya/service_locator.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String timezone = DateTime.now().timeZoneName;
  Position? position;
  bool isSearchActive = false;
  final TextEditingController searchController = TextEditingController();
  String currentTime = '';
  String nextPrayerText = 'Calculating...';

  @override
  void initState() {
    super.initState();
    currentTime = sl<TimeUsecase>().getCurrentTIme();

    final location = sl<GetlocationUseCase>();
    location().then((value) {
      setState(() {
        position = value;
        if (position != null) {
          _calculatePrayerTimes();
        }
      });
    }).catchError((error) {
      print('Failed to get location: $error');
    });

    Timer.periodic(const Duration(minutes: 1), (Timer t) {
      setState(() {
        currentTime = sl<TimeUsecase>().getCurrentTIme();
        if (position != null) {
          _calculatePrayerTimes();
        }
      });
    });
  }

  void _calculatePrayerTimes() {
    final coordinates = Coordinates(position!.latitude, position!.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;

    final prayerTimes = PrayerTimes.today(coordinates, params);

    final currentDateTime = DateTime.now();
    final nextPrayer = prayerTimes.nextPrayer();
    final remainingDuration =
        prayerTimes.timeForPrayer(nextPrayer)?.difference(currentDateTime);

    if (remainingDuration != null && nextPrayer != null) {
      setState(() {
        nextPrayerText =
            '${nextPrayer.name} ${remainingDuration.inHours} hours ${remainingDuration.inMinutes % 60} minutes left';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(PageAnimationTransition(
                  page: const SearchPage(),
                  pageAnimationType: FadeAnimationTransition()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          currentTime,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          nextPrayerText,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const HomeCard(),
            const SizedBox(height: 150, child: Features()),
            const RandomVersePage()
          ],
        ),
      ),
    );
  }
}