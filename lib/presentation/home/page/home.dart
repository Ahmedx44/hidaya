import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:hidaya/presentation/chat/page/chat_list.dart';
import 'package:hidaya/presentation/home/page/homepage.dart';
import 'package:hidaya/presentation/home/widget/my_drawer.dart';
import 'package:hidaya/presentation/profile/page/profile.dart';
import 'package:hidaya/presentation/search/page/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page = const HomePage();

    if (pageIndex == 0) {
      setState(() {
        page = const HomePage();
      });
    } else if (pageIndex == 1) {
      setState(() {
        page = const SearchPage();
      });
    } else if (pageIndex == 2) {
      setState(() {
        page = const ChatListPage();
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
            TabItem(icon: Icons.search, title: 'Search'),
            TabItem(icon: Icons.chat, title: 'Chat'),
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
