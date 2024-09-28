import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';
import 'package:hidaya/domain/usecase/user/get_user_data_usecase.dart';
import 'package:hidaya/presentation/profile/bloc/profile_bloc/profile_cubit.dart';
import 'package:hidaya/presentation/profile/bloc/profile_bloc/profile_state.dart';
import 'package:hidaya/presentation/profile/page/edit_profile.dart';
import 'package:hidaya/service_locator.dart';

class ProfileScreen extends StatelessWidget {
  final String userId = FirebaseAuth
      .instance.currentUser!.uid; // Replace with your actual user ID
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<DateTime, int>> _getHeatmapData() async {
    final userDoc = await _firestore.collection('User').doc(userId).get();
    List<Map<String, dynamic>> heatmap =
        List<Map<String, dynamic>>.from(userDoc.get('heatmap') ?? []);

    Map<DateTime, int> heatmapData = {};
    for (var entry in heatmap) {
      final dateParts = entry['date'].split('-');
      final date = DateTime(int.parse(dateParts[0]), int.parse(dateParts[1]),
          int.parse(dateParts[2]));
      heatmapData[date] = entry['count'];
    }

    return heatmapData;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(sl<GetUserDataUsecase>())..getUser(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileStateLoaded) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                title: const Text("Profile"),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: FutureBuilder<Map<DateTime, int>>(
                  future: _getHeatmapData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          FutureBuilder(
                            future: state.user,
                            builder: (context, snapshot) {
                              return ProfilePic(
                                profile: snapshot.hasData
                                    ? snapshot.data!['imageUrl']
                                    : '',
                                name: snapshot.hasData
                                    ? snapshot.data!['fullName']
                                    : '',
                              );
                            },
                          ),
                          HeatMap(
                            colorMode: ColorMode.color,
                            showText: false,
                            textColor:
                                Theme.of(context).colorScheme.inversePrimary,
                            scrollable: true,
                            colorsets: {
                              1: const Color.fromARGB(255, 220, 247,
                                  190), // Light color for low counts
                              2: const Color.fromARGB(255, 202, 245, 152),
                              3: const Color.fromARGB(255, 181, 248, 105),
                              4: const Color.fromARGB(255, 143, 245, 54),
                              5: const Color.fromARGB(255, 73, 252,
                                  2), // Bright color for high counts
                            },
                            onClick: (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(value.toString())),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          ProfileMenu(
                            text: "My Account",
                            icon: const Icon(Icons.person),
                            press: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const EditProfileScreen();
                              }));
                            },
                          ),
                          ProfileMenu(
                            text: "Settings",
                            icon: Icon(Icons.settings),
                            press: () {},
                          ),
                          ProfileMenu(
                            text: "Help Center",
                            icon: Icon(Icons.help),
                            press: () {},
                          ),
                          ProfileMenu(
                            text: "Log Out",
                            icon: Icon(Icons.logout),
                            press: () {
                              FirebaseAuth.instance.signOut();
                            },
                          ),
                        ],
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading heatmap data'));
                    }

                    final heatmapData = snapshot.data ?? {};

                    return Column(
                      children: [
                        FutureBuilder(
                          future: state.user,
                          builder: (context, snapshot) {
                            return ProfilePic(
                              profile: snapshot.hasData
                                  ? snapshot.data!['imageUrl']
                                  : '',
                              name: snapshot.hasData
                                  ? snapshot.data!['fullName']
                                  : '',
                            );
                          },
                        ),
                        HeatMap(
                          datasets: heatmapData,
                          colorMode: ColorMode.color,
                          showText: false,
                          textColor:
                              Theme.of(context).colorScheme.inversePrimary,
                          scrollable: true,
                          colorsets: {
                            1: const Color.fromARGB(255, 220, 247,
                                190), // Light color for low counts
                            2: const Color.fromARGB(255, 202, 245, 152),
                            3: const Color.fromARGB(255, 181, 248, 105),
                            4: const Color.fromARGB(255, 143, 245, 54),
                            5: const Color.fromARGB(255, 73, 252,
                                2), // Bright color for high counts
                          },
                          onClick: (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(value.toString())),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        ProfileMenu(
                          text: "My Account",
                          icon: const Icon(Icons.person),
                          press: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const EditProfileScreen();
                            }));
                          },
                        ),
                        ProfileMenu(
                          text: "Settings",
                          icon: Icon(Icons.settings),
                          press: () {},
                        ),
                        ProfileMenu(
                          text: "Help Center",
                          icon: Icon(Icons.help),
                          press: () {},
                        ),
                        ProfileMenu(
                          text: "Log Out",
                          icon: Icon(Icons.logout),
                          press: () {
                            FirebaseAuth.instance.signOut();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  final String profile;
  final String name;
  const ProfilePic({Key? key, required this.profile, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundImage: profile.isNotEmpty
                    ? CachedNetworkImageProvider(profile)
                    : AssetImage(AppImage.profile) as ImageProvider,
              ),
            ],
          ),
        ),
        Text(
          name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final Icon icon;
  final String text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Theme.of(context).colorScheme.onTertiary,
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF757575),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF757575),
            ),
          ],
        ),
      ),
    );
  }
}
