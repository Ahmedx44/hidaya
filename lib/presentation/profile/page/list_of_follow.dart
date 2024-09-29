import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hidaya/core/config/assets/image/app_image.dart';

class ListOfFollowers extends StatelessWidget {
  final String email;
  const ListOfFollowers({super.key, required this.email});

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserDocument() {
    return FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getFollowingUsers(
      List<String> followingIds) {
    if (followingIds.isEmpty) {
      return Stream.value([]);
    }

    return FirebaseFirestore.instance
        .collection('User')
        .where(FieldPath.documentId, whereIn: followingIds.take(10).toList())
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Follower')),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getUserDocument(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userSnapshot.hasError) {
            return const Center(child: Text('Error fetching user data'));
          }

          if (!userSnapshot.hasData || userSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No user data found'));
          }

          final followingIds = List<String>.from(
              userSnapshot.data!.docs.first['followers'] ?? []);

          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: getFollowingUsers(followingIds),
            builder: (context, followingSnapshot) {
              if (followingSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (followingSnapshot.hasError) {
                return const Center(
                    child: Text('Error fetching following users'));
              }

              if (!followingSnapshot.hasData ||
                  followingSnapshot.data!.isEmpty) {
                return const Center(child: Text('No following users found'));
              }

              return ListView.builder(
                itemCount: followingSnapshot.data!.length,
                itemBuilder: (context, index) {
                  final userData = followingSnapshot.data![index];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: userData['imageUrl'] != null
                              ? CachedNetworkImageProvider(userData['imageUrl'])
                                  as ImageProvider
                              : AssetImage(AppImage.profile),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          userData['fullName'],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
