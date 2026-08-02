import 'package:flutter/material.dart';
import '../screens/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final Function(bool?) onChanged;

  const TaskCard({
    super.key,
    required this.task,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
