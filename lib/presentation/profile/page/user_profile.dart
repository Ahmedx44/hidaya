import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';
import 'package:hidaya/domain/usecase/user/follow_user_usecase.dart';
import 'package:hidaya/domain/usecase/user/unfollow_user_usecase.dart';
import 'package:hidaya/service_locator.dart';

class UserProfile extends StatefulWidget {
  final user;
  const UserProfile({super.key, required this.user});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isFollowing = false; // Local state to track follow status
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.user['followers'] != null &&
        widget.user['followers'].contains(currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    _getHeatmapData() {
      Map<DateTime, int> heatmapData = {};
      for (var entry in widget.user['heatmap']) {
        final dateParts = entry['date'].split('-');
        final date = DateTime(
          int.parse(dateParts[0]),
          int.parse(dateParts[1]),
          int.parse(dateParts[2]),
        );
        heatmapData[date] = entry['count'];
      }
      return heatmapData;
    }

    List follower = widget.user['followers'] ?? [];
    List following = widget.user['following'] ?? [];

    void showLoadingDialog(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              SizedBox(
                height: 150,
                width: 150,
                child: CircleAvatar(
                  backgroundImage: widget.user['imageUrl'] != null &&
                          widget.user['imageUrl'].isNotEmpty
                      ? CachedNetworkImageProvider(widget.user['imageUrl'])
                      : AssetImage(AppImage.profile) as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.user['fullName'] ?? 'Unknown User',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn('Followers', follower.length),
                  _buildStatColumn('Following', following.length),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isFollowing)
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onPressed: () async {
                        showLoadingDialog(context);
                        String result = await sl<FollowUserUsecase>()
                            .call(widget.user['email']);

                        // Close the loading dialog
                        Navigator.pop(context);

                        // Check the result and update the state accordingly
                        if (result == 'Followed') {
                          setState(() {
                            isFollowing = true;
                          });
                        }
                      },
                      child: Text(
                        'Follow',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  if (isFollowing)
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      onPressed: () async {
                        showLoadingDialog(context);
                        String result = await sl<UnfollowUserUsecase>()
                            .call(widget.user['email']);

                        // Close the loading dialog
                        Navigator.pop(context);

                        // Check the result and update the state accordingly
                        if (result == 'UnFollow') {
                          setState(() {
                            isFollowing = false;
                          });
                        }
                      },
                      child: Text(
                        'Unfollow',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Message',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Quran Habit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: HeatMap(
                  textColor: Theme.of(context).colorScheme.inversePrimary,
                  datasets: _getHeatmapData(),
                  colorMode: ColorMode.color,
                  scrollable: true,
                  colorsets: {
                    1: const Color.fromARGB(255, 220, 247, 190),
                    2: const Color.fromARGB(255, 202, 245, 152),
                    3: const Color.fromARGB(255, 181, 248, 105),
                    4: const Color.fromARGB(255, 143, 245, 54),
                    5: const Color.fromARGB(255, 73, 252, 2),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, int count) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
