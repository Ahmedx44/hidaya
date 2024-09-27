import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class UserProfile extends StatelessWidget {
  final user;
  const UserProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    _getHeatmapData() {
      Map<DateTime, int> heatmapData = {};
      for (var entry in user['heatmap']) {
        final dateParts = entry['date'].split('-');
        final date = DateTime(int.parse(dateParts[0]), int.parse(dateParts[1]),
            int.parse(dateParts[2]));
        heatmapData[date] = entry['count'];
      }

      return heatmapData;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user['imageUrl']),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              user['fullName'],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: HeatMap(
                datasets: _getHeatmapData(),
                colorMode: ColorMode.color,
                scrollable: true,
                colorsets: {
                  1: const Color.fromARGB(
                      255, 220, 247, 190)!, // Light color for low counts
                  2: const Color.fromARGB(255, 202, 245, 152)!,
                  3: const Color.fromARGB(255, 181, 248, 105)!,
                  4: const Color.fromARGB(255, 143, 245, 54)!,
                  5: const Color.fromARGB(
                      255, 73, 252, 2)!, // Bright color for high counts
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
