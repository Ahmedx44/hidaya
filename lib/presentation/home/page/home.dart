import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hidaya/domain/usecase/location/getLocation.dart';
import 'package:hidaya/presentation/home/widget/features.dart';
import 'package:hidaya/presentation/home/widget/home_card.dart';
import 'package:hidaya/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String timezone = DateTime.now().timeZoneName;
  Position? position;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    final location = sl<GetlocationUseCase>();
    location().then((value) {
      setState(() {
        position = value;
      });
    }).catchError((error) {
      // Handle any errors while fetching the location here
      print('Failed to get location: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Altitude: ${position!.latitude}');
    print('Longitude: ${position!.longitude}');

    print('Timezone: $timezone');

    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(),
      bottomNavigationBar: BottomBarInspiredFancy(
        items: const [
          TabItem(icon: FlutterIslamicIcons.kaaba, title: 'Home'),
          TabItem(icon: Icons.message_outlined, title: 'Chat'),
          TabItem(icon: FlutterIslamicIcons.prayer, title: 'Prayer'),
          TabItem(icon: FlutterIslamicIcons.community, title: 'Community'),
        ],
        backgroundColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).colorScheme.inversePrimary,
        colorSelected: Theme.of(context).colorScheme.primary,
        indexSelected: pageIndex,
        styleIconFooter: StyleIconFooter.dot,
        onTap: (int index) => setState(() {
          pageIndex = index;
        }),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
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
                        '4:41',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Fajr 3 hours 9 minutes left',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const HomeCard(),
          const SizedBox(height: 200, child: Features()),
        ],
      ),
    );
  }
}
