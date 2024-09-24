import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hidaya/presentation/home/page/homepage.dart';
import 'package:hidaya/presentation/home/widget/my_drawer.dart';
import 'package:hidaya/presentation/profile/page/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page = HomePage();

    if (pageIndex == 0) {
      setState(() {
        page = HomePage();
      });
    } else if (pageIndex == 3) {
      setState(() {
        page = ProfileScreen();
      });
    }

    if (pageIndex == 0) {}
    return Scaffold(
        drawer: const MyDrawer(),
        bottomNavigationBar: BottomBarDefault(
          items: const [
            TabItem(icon: FlutterIslamicIcons.kaaba, title: 'Home'),
            TabItem(icon: Icons.message_outlined, title: 'Chat'),
            TabItem(icon: Icons.chat, title: 'Prayer'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          backgroundColor: Theme.of(context).colorScheme.surface,
          color: Theme.of(context).colorScheme.inversePrimary,
          colorSelected: Theme.of(context).colorScheme.primary,
          indexSelected: pageIndex,
          onTap: (int index) => setState(() {
            pageIndex = index;
          }),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: page);
  }
}
