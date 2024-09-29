import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  Future<String> createOrGetChatRoomId(String targetUserEmail) async {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    final chatRoomId = currentUserEmail.compareTo(targetUserEmail) > 0
        ? "$targetUserEmail\_$currentUserEmail"
        : "$currentUserEmail\_$targetUserEmail";

    final chatRoomRef =
        FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId);

    // Check if the chat room exists
    final chatRoomSnapshot = await chatRoomRef.get();
    if (!chatRoomSnapshot.exists) {
      // Create a new chat room
      await chatRoomRef.set({
        'participants': [currentUserEmail, targetUserEmail],
        'lastMessage': '',
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    return chatRoomId;
  }
}
