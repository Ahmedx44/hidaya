import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hidaya/domain/usecase/location/getLocation.dart';
import 'package:hidaya/domain/usecase/time/time_usecase.dart';
import 'package:hidaya/domain/usecase/user/get_userName_useCase.dart';
import 'package:hidaya/presentation/home/bloc/get_user_bloc/get_username_cubit.dart';
import 'package:hidaya/presentation/home/bloc/get_user_bloc/get_username_state.dart';
import 'package:hidaya/presentation/home/widget/features.dart';
import 'package:hidaya/presentation/home/widget/home_card.dart';
import 'package:hidaya/presentation/home/widget/randomVerse.dart';
import 'package:hidaya/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String timezone = DateTime.now().timeZoneName;
  Position? position;
  bool isSearchActive = false;
  final TextEditingController searchController = TextEditingController();
  String currentTime = '';
  String nextPrayerText = 'Fetching prayer times...';
  final user = FirebaseAuth.instance;

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
      // Handle location fetching error
      setState(() {
        nextPrayerText = 'Failed to fetch location';
      });
    });

    Timer.periodic(const Duration(seconds: 2), (Timer t) {
      setState(() {
        currentTime = sl<TimeUsecase>().getCurrentTIme();
        if (position != null) {
          _calculatePrayerTimes();
        }
      });
    });
  }

  void _calculatePrayerTimes() {
    if (position == null) return; // Ensure position is not null

    final coordinates = Coordinates(position!.latitude, position!.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;

    final prayerTimes = PrayerTimes.today(coordinates, params);

    final currentDateTime = DateTime.now();
    final nextPrayer = prayerTimes.nextPrayer();
    final remainingDuration =
        prayerTimes.timeForPrayer(nextPrayer)?.difference(currentDateTime);

    print('Position: $position'); // Debugging statement
    print('Next Prayer: ${nextPrayer.name}'); // Debugging statement
    print('Remaining Duration: $remainingDuration'); // Debugging statement

    if (nextPrayer != Prayer.none && remainingDuration != null) {
      setState(() {
        nextPrayerText =
            '${nextPrayer.name} in ${remainingDuration.inHours} hours and ${remainingDuration.inMinutes % 60} minutes';
      });
    } else {
      setState(() {
        nextPrayerText = 'No more prayers today'; // Show a meaningful message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetUsernameCubit(sl<GetUsernameUsecase>())..getUserName(),
      child: BlocBuilder<GetUsernameCubit, GetUsernameState>(
        builder: (context, state) {
          if (state is GetUsernameLoaded) {
            return FutureBuilder(
              future: state.user,
              builder: (context, snapshot) {
                return Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  appBar: AppBar(
                    centerTitle: false,
                    title: snapshot.hasData
                        ? Text('Hello ${snapshot.data?['fullName'].toString()}')
                        : const Text('User'),
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 70,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      nextPrayerText,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
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
              },
            );
          } else {
            return const Center(
              child:
                  CircularProgressIndicator(), // Show a loader while fetching data
            );
          }
        },
      ),
    );
  }
}
