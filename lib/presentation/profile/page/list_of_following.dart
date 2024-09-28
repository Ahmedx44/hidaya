import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListOfFollowing extends StatelessWidget {
  const ListOfFollowing({super.key});

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDocument() {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('User')
        .doc(user!.uid)
        .snapshots();
  }

  Stream<List<Map<String, dynamic>>> getFollowingUsers(
      List<String> followingIds) {
    return FirebaseFirestore.instance
        .collection('User')
        .where(FieldPath.documentId, whereIn: followingIds)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Following')),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: getUserDocument(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userSnapshot.hasError) {
            return const Center(child: Text('Error fetching user data'));
          }

          if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
            return const Center(child: Text('No user data found'));
          }

          // Extract following IDs from the user document
          final followingIds =
              List<String>.from(userSnapshot.data!['following'] ?? []);

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
                    title: Text(userData['fullName'] ??
                        'Unnamed User'), // Assuming fullName is a field in the user document
                    subtitle: Text(userData['email'] ??
                        'No email'), // Assuming email is a field in the user document
                    // Optionally add an onTap to navigate to user profile, etc.
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
