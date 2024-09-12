import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hidaya/presentation/Page/home/widget/mini_card.dart';

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Features',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              Text('See all',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary)),
            ],
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                MiniCard(
                    icon: FlutterIslamicIcons.solidQuran2, feature: 'Quran'),
                SizedBox(
                  width: 20,
                ),
                MiniCard(icon: Icons.audio_file, feature: 'Hadith'),
                SizedBox(
                  width: 20,
                ),
                MiniCard(
                    icon: Icons.edit_calendar_outlined, feature: 'Reminder'),
                SizedBox(
                  width: 20,
                ),
                MiniCard(icon: Icons.handshake, feature: 'Charity'),
                SizedBox(
                  width: 20,
                ),
                MiniCard(
                    icon: FlutterIslamicIcons.qibla, feature: 'Qibla Direction')
              ],
            ),
          )
        ],
      ),
    );
  }
}
