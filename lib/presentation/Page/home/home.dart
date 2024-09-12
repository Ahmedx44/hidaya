import 'package:flutter/material.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';
import 'package:hidaya/presentation/Page/home/widget/features.dart';
import 'package:hidaya/presentation/Page/home/widget/home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image(
                    height: 200, image: AssetImage(AppImage.pattern_left)),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Image(
                    height: 200, image: AssetImage(AppImage.pattern_right)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 70),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        '4:41',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Fajr 3 hour 9 minute left ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const HomeCard(),
          SizedBox(height: 200, child: Features())
        ],
      ),
    );
  }
}
