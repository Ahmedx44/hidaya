import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';
import 'package:hidaya/data/source/chat/chat_service.dart';
import 'package:hidaya/domain/usecase/user/follow_user_usecase.dart';
import 'package:hidaya/domain/usecase/user/get_user_profile_usecase.dart';
import 'package:hidaya/domain/usecase/user/unfollow_user_usecase.dart';
import 'package:hidaya/presentation/chat/page/chat_page.dart';
import 'package:hidaya/presentation/profile/page/list_of_follow.dart';
import 'package:hidaya/presentation/profile/page/list_of_following.dart';
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

  final ChatService _chatService = ChatService();

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
              StreamBuilder(
                stream: sl<GetUserProfileUsecase>().call(widget.user['email']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Display a loading spinner while waiting for data
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final user = snapshot.data!.docs.first.data();
                  final followerCount = user['followers'].length ?? 0;
                  final followingCount = user['following'].length ?? 0;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ListOfFollowers(
                                  email: user['email'],
                                );
                              },
                            ));
                          },
                          child: _buildStatColumn('Followers', followerCount)),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ListOfFollowing(
                                  email: user['email'],
                                );
                              },
                            ));
                          },
                          child: _buildStatColumn('Following', followingCount)),
                    ],
                  );
                },
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
                        if (result == 'Unfollowed') {
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
                    onPressed: () async {
                      final chatRoomId = await _chatService
                          .createOrGetChatRoomId(widget.user['email']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            chatRoomId: chatRoomId,
                            userName: widget.user['fullName'] ?? 'Unknown User',
                            userImageUrl: widget.user['imageUrl'],
                          ),
                        ),
                      );
                    },
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
                  'Quran Reading Habit',
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
                  colorsets: const {
                    1: Color.fromARGB(255, 220, 247, 190),
                    2: Color.fromARGB(255, 202, 245, 152),
                    3: Color.fromARGB(255, 181, 248, 105),
                    4: Color.fromARGB(255, 143, 245, 54),
                    5: Color.fromARGB(255, 73, 252, 2),
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
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
        Text(
          count.toString(),
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
