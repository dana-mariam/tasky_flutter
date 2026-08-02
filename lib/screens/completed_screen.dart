import 'package:flutter/material.dart';
import 'package:projj/screens/shared_pref_service.dart';
import 'package:projj/screens/task_model.dart';
import 'package:projj/widgets/task_list.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    tasks = await SharedPrefService.getTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<TaskModel> completedTasks =
    tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed"),
      ),
      body: completedTasks.isEmpty
          ? const Center(
        child: Text(
          "No Completed Tasks",
          style: TextStyle(fontSize: 20),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(20),
        child: TaskList(
          tasks: completedTasks,

          onChanged: (task, value) async {
            setState(() {
              task.isCompleted = value!;
            });

            await SharedPrefService.saveTasks(tasks);

            loadTasks();
          },

          onDelete: (task) async {
            setState(() {
              tasks.remove(task);
            });

            await SharedPrefService.saveTasks(tasks);

            loadTasks();
          },
        ),
      ),
    );
  }
}