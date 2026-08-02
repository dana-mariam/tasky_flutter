import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do"),
      ),
      body: const Center(
        child: Text(
          "To Do Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}