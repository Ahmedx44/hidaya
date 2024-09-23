import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hidaya/core/config/assets/vector/app_vector.dart';
import 'package:hidaya/presentation/auth/pages/sigin.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: SvgPicture.asset(
            Appvector.quran,
          )),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) {
              //     return SignInScreen();
              //   },
              // ));
            },
            child: ListTile(
              leading: Icon(Icons.logout,
                  color: Theme.of(context).colorScheme.inversePrimary),
              title: Text(
                'L O G O U T',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
          )
        ],
      ),
    );
  }
}
