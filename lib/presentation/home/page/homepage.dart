import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';
import 'package:hidaya/domain/usecase/location/getLocation.dart';
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
  Position? position;
  String nextPrayerText = '';
  String lastKnownNextPrayerText = '';
  final user = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    final location = sl<GetlocationUseCase>();
    location().then((value) {
      setState(() {
        position = value;
        if (position != null) {
          _calculatePrayerTimes();
        }
      });
    }).catchError((error) {
      setState(() {
        nextPrayerText = 'Failed to fetch location';
      });
    });
  }

  void _calculatePrayerTimes() {
    if (position == null) return;

    final coordinates = Coordinates(position!.latitude, position!.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;

    final prayerTimes = PrayerTimes.today(coordinates, params);
    final currentDateTime = DateTime.now();
    final nextPrayer = prayerTimes.nextPrayer();
    final remainingDuration =
        prayerTimes.timeForPrayer(nextPrayer)?.difference(currentDateTime);

    if (nextPrayer != Prayer.none && remainingDuration != null) {
      final newNextPrayerText =
          '${nextPrayer.name} in ${remainingDuration.inHours} hours and ${remainingDuration.inMinutes % 60} minutes';
      setState(() {
        lastKnownNextPrayerText = nextPrayerText;
        nextPrayerText = newNextPrayerText;
      });
    } else {
      setState(() {
        nextPrayerText = 'No more prayers today';
      });
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
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
                    title: Container(
                      width: 300,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                fit: BoxFit.cover,
                                image: snapshot.hasData && snapshot.data != null
                                    ? ExtendedNetworkImageProvider(
                                        cache: true, snapshot.data!['imageUrl'])
                                    : AssetImage(AppImage.profile),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Aselamalyekum Werhamtulahi ahmed',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text('Hello ${snapshot.data!['fullName']}',
                                  style: const TextStyle(fontSize: 14))
                            ],
                          )
                        ],
                      ),
                    ),
                    // snapshot.connectionState == ConnectionState.waiting
                    //     ? const Text('Hello',
                    //         style: TextStyle(
                    //           fontSize: 17,
                    //         ))
                    //     : snapshot.hasData && snapshot.data != null
                    //         ? Row(
                    //             children: [
                    //               const Text(
                    //                 'Hello ',
                    //                 style: TextStyle(
                    //                     fontSize: 17,
                    //                     fontWeight: FontWeight.bold),
                    //               ),
                    //               Text(
                    //                 '${snapshot.data?['fullName']?.toString() ?? 'User'}',
                    //                 style: const TextStyle(
                    //                   fontSize: 17,
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         : const Text('Welcome'),
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
                                      _getCurrentTime(), // Get the current time instantly
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 70,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      nextPrayerText.isNotEmpty
                                          ? nextPrayerText
                                          : lastKnownNextPrayerText, // Use last known time if nextPrayerText is empty
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
