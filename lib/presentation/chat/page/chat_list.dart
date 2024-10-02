import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';
import 'package:hidaya/presentation/chat/widget/chat_list_skeleton.dart';
import 'chat_page.dart'; // Make sure to import your ChatPage file

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat List'),
      ),
      body: FutureBuilder<List<String>>(
        future: getChatRooms(user?.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ChatListSkeleton(),
                  SizedBox(height: 10),
                  ChatListSkeleton(),
                  SizedBox(height: 10),
                  ChatListSkeleton()
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final chatRooms = snapshot.data!;
            return ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
                final otherEmail =
                    chatRoom.replaceAll(user!.email!, '').replaceAll('_', '');

                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('User')
                      .where('email', isEqualTo: otherEmail)
                      .limit(1)
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            ChatListSkeleton(),
                            SizedBox(height: 10),
                            ChatListSkeleton(),
                            SizedBox(height: 10),
                            ChatListSkeleton()
                          ],
                        ),
                      );
                    } else if (userSnapshot.hasError) {
                      return Center(
                        child: Text('Error loading user'),
                      );
                    } else if (!userSnapshot.hasData ||
                        userSnapshot.data!.docs.isEmpty) {
                      return const ListTile(title: Text('User not found'));
                    } else {
                      final otherUser = userSnapshot.data!.docs.first;
                      final fullName = otherUser['fullName'] ?? 'Unknown User';
                      final userImageUrl = otherUser[
                          'imageUrl']; // Assuming there's an imageUrl field

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                chatRoomId: chatRoom,
                                userName: fullName,
                                userImageUrl: userImageUrl,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onTertiary,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: userImageUrl.isNotEmpty
                                    ? CachedNetworkImageProvider(userImageUrl)
                                    : AssetImage(AppImage.profile)
                                        as ImageProvider,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                fullName,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No chat rooms found.'));
          }
        },
      ),
    );
  }

  Future<List<String>> getChatRooms(String? email) async {
    if (email == null) return [];

    final chatRoomSnapshots = await FirebaseFirestore.instance
        .collection('chatRooms')
        .where('participants', arrayContains: email)
        .get();

    return chatRoomSnapshots.docs.map((doc) => doc.id).toList();
  }
}
