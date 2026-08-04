import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String username;

  const HomeHeader({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 30,
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Evening, $username",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "One task at a time.\nOne step closer.",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: const Icon(Icons.light_mode),
        ),
      ],
    );
  }
}