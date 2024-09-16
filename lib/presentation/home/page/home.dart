import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';
import 'package:hidaya/presentation/home/widget/features.dart';
import 'package:hidaya/presentation/home/widget/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int pageIndex = 0;
    return Scaffold(
      bottomNavigationBar: BottomBarInspiredFancy(
        items: const [
          TabItem(icon: FlutterIslamicIcons.kaaba, title: 'Home'),
          TabItem(icon: Icons.message_outlined, title: 'Chat'),
          TabItem(icon: FlutterIslamicIcons.prayer, title: 'Prayer'),
          TabItem(icon: FlutterIslamicIcons.community, title: 'Community')
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 70),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        '4:41',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Fajr 3 hour 9 minute left ',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const HomeCard(),
          const SizedBox(height: 200, child: Features())
        ],
      ),
    );
  }
}
