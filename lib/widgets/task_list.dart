import 'package:flutter/material.dart';
import 'package:projj/screens/task_model.dart';
import 'task_card.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;

  final Function(TaskModel, bool?) onChanged;

  final Function(TaskModel) onDelete;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        TaskModel task = tasks[index];

        return Dismissible(
          key: Key(task.title + index.toString()),

          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),

          onDismissed: (_) {
            onDelete(task);
          },

          child: TaskCard(
            task: task,
            onChanged: (value) {
              onChanged(task, value);
            },
          ),
        );
      },
    );
  }
}