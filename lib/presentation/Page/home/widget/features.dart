import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

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
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.primary,
                  )),
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    FlutterIslamicIcons.quran2,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
