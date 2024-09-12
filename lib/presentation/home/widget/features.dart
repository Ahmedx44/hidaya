import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hidaya/presentation/home/widget/mini_card.dart';
import 'package:hidaya/presentation/quran_surah/page/quran_surah_list.dart';

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
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
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return QuranSurahList();
                      },
                    ));
                  },
                  child: MiniCard(
                      icon: FlutterIslamicIcons.solidQuran2, feature: 'Quran'),
                ),
                MiniCard(icon: Icons.audio_file, feature: 'Hadith'),
                MiniCard(
                    icon: Icons.edit_calendar_outlined, feature: 'Reminder'),
                MiniCard(icon: Icons.handshake, feature: 'Charity'),
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
