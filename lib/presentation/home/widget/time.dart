import 'package:flutter/material.dart';
import 'package:hidaya/data/source/location/location_service.dart';
import 'package:hidaya/service_locator.dart';

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  @override
  void initState() async {
    super.initState();
    final location = await sl<LocationService>().getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Ensures the Column takes only as much space as it needs
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
              'Fajr 3 hour 9 minutes left',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
