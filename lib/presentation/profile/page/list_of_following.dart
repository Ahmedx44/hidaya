import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListOfFollowing extends StatelessWidget {
  final String email;
  const ListOfFollowing({super.key, required this.email});

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserDocument() {
    return FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getFollowingUsers(
      List<String> followingIds) {
    if (followingIds.isEmpty) {
      return Stream.value(
          []); // Return an empty stream if there are no following IDs
    }

    return FirebaseFirestore.instance
        .collection('User')
        .where(FieldPath.documentId,
            whereIn: followingIds
                .take(10)
                .toList()) // Limit to 10 for Firestore constraints
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Following')),
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

          // Extract following IDs from the user document
          final followingIds = List<String>.from(
              userSnapshot.data!.docs.first['following'] ?? []);

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

              // Build the list of following users
              return ListView.builder(
                itemCount: followingSnapshot.data!.length,
                itemBuilder: (context, index) {
                  final userData = followingSnapshot.data![index];
                  return ListTile(
                    title: Text(userData['fullName'] ?? 'Unnamed User'),
                    subtitle: Text(userData['email'] ?? 'No email'),
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
