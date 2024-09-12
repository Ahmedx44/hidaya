import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

class MiniCard extends StatelessWidget {
  final IconData icon;
  final String feature;
  const MiniCard({super.key, required this.icon, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary,
              )),
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            size: 30,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          feature,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        )
      ],
    );
  }
}
