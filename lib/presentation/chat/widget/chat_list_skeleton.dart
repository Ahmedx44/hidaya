import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatListSkeleton extends StatelessWidget {
  const ChatListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          // Circle placeholder for image
          Container(
            width: 60, // Diameter of the CircleAvatar
            height: 60, // Diameter of the CircleAvatar
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 20),
          // Container placeholder for text
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 20,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
