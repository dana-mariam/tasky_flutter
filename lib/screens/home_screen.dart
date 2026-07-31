import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'add_task_screen.dart';
import 'shared_pref_service.dart';
import 'task_model.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// قائمة المهام
  List<TaskModel> tasks = [];
  @override
  void initState() {
    super.initState();
    loadTasks();
  }

// تحميل المهام من SharedPreferences
  Future<void> loadTasks() async {
    tasks = await SharedPrefService.getTasks();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ===============================
      // Background Color
      // ===============================
      backgroundColor: Colors.white,

      // ===============================
      // App Bar
      // ===============================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,

        title: const Text(
          "Tasky",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [

          Padding(
            padding: const EdgeInsets.only(right: 15),

            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blue,

              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),

      // ===============================
      // Body
      // ===============================
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Greeting
            const Text(
              "Good Evening 👋",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "One task at a time.\nOne step closer.",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),


        Expanded(
          child: tasks.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_alt,
                  size: 80,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 15),
                const Text(
                  "No Tasks Yet",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Press the button below\nand add your first task.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
              : ListView.builder(
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

                onDismissed: (_) async {

                  setState(() {
                    tasks.removeAt(index);
                  });

                  await SharedPrefService.saveTasks(tasks);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Task Deleted"),
                    ),
                  );
                },

                child: Card(
                  margin: const EdgeInsets.only(bottom: 15),

                  child: ListTile(

                    title: Text(task.title),

                    subtitle: Text(task.description),

                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) async {

                        setState(() {
                          task.isCompleted = value!;
                        });

                        await SharedPrefService.saveTasks(tasks);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
          ],
        ),
      ),


      // ===============================
      // Floating Action Button
      // ===============================
      floatingActionButton: FloatingActionButton.extended(

        backgroundColor: Colors.blue,

        onPressed: () async{

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );

// عند الرجوع حمّل المهام من جديد
          loadTasks();

        },

        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        label: const Text(
          "New Task",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}