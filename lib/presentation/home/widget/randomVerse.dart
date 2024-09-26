import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hidaya/data/source/quran/quran_service.dart';
import 'package:hidaya/service_locator.dart';

import 'package:share_plus/share_plus.dart';

class RandomVersePage extends StatefulWidget {
  const RandomVersePage({super.key});

  @override
  State<RandomVersePage> createState() => _RandomVersePageState();
}

class _RandomVersePageState extends State<RandomVersePage> {
  String randomversEnglish = '';
  String verseName = '';

  @override
  void initState() {
    super.initState();
    final result = sl<QuranService>().getRandoVerse();

    setState(() {
      randomversEnglish = result.translation;
    });

    Timer.periodic(Duration(days: 0), (Timer t) {
      setState(() {
        verseName = sl<QuranService>().getSurah(result.surahNumber);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Message of the Day',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 300,
            child: Column(
              children: [
                Text(
                  'Surah ${verseName}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  randomversEnglish,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          try {
                            await Share.share(
                              'Surah $verseName\n$randomversEnglish',
                              sharePositionOrigin:
                                  Rect.fromLTWH(0, 0, 100, 100),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to share: $e')),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.share,
                          size: 20,
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
