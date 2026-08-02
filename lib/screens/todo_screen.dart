import 'package:flutter/material.dart';
import 'package:projj/screens/shared_pref_service.dart';
import 'package:projj/screens/task_model.dart';
import 'package:projj/widgets/task_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
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
    List<TaskModel> todoTasks =
    tasks.where((task) => !task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do"),
      ),

      body: todoTasks.isEmpty
          ? const Center(
        child: Text(
          "No Tasks Yet",
          style: TextStyle(fontSize: 20),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(20),
        child: TaskList(
          tasks: todoTasks,

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