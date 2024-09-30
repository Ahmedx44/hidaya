import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hidaya/presentation/hadith/page/hadiths_list.dart';
import 'package:hidaya/presentation/home/widget/mini_card.dart';
import 'package:hidaya/presentation/qibala/page/qibla.dart';
import 'package:hidaya/presentation/quran_surah_list/page/quran_surah_list.dart';

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
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
                        return const QuranSurahList();
                      },
                    ));
                  },
                  child: const MiniCard(
                      icon: FlutterIslamicIcons.solidQuran2, feature: 'Quran'),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HadithsList();
                        },
                      ));
                    },
                    child: const MiniCard(
                        icon: FlutterIslamicIcons.islam, feature: 'Hadith')),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return QiblaCompass();
                      },
                    ));
                  },
                  child: MiniCard(
                      icon: FlutterIslamicIcons.qibla,
                      feature: 'Qibla Direction'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
