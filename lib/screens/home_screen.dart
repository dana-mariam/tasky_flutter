import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'add_task_screen.dart';
import 'shared_pref_service.dart';
import 'task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo_screen.dart';
import 'completed_screen.dart';
import 'profile_screen.dart';
import 'package:projj/widgets/task_card.dart';
import 'package:projj/widgets/task_list.dart';
import 'package:projj/widgets/home_header.dart';
import 'package:projj/widgets/progress_card.dart';
class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
// قائمة المهام
  List<TaskModel> tasks = [];
  @override
  void initState() {
    super.initState();
    loadTasks();
    getUsername();
  }
  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString("username") ?? "Guest";
    });
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
            HomeHeader(
              username: username,
            ),

            const SizedBox(height: 30),

            const Text(
              "Yuhuu, Your work is\nalmost done! 👋",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            ProgressCard(
              completedTasks:
              tasks.where((task) => task.isCompleted).length,
              totalTasks: tasks.length,
            ),

            const SizedBox(height: 30),



            const SizedBox(height: 20),


            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "High Priority Tasks",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    TaskList(
                      tasks: tasks.where((e) => e.isHighPriority).toList(),
                      onChanged: (task, value) async {
                        setState(() {
                          task.isCompleted = value!;
                        });
                        await SharedPrefService.saveTasks(tasks);
                      },
                      onDelete: (task) async {
                        setState(() {
                          tasks.remove(task);
                        });
                        await SharedPrefService.saveTasks(tasks);
                      },
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "My Tasks",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    TaskList(
                      tasks: tasks.where((e) => !e.isHighPriority).toList(),
                      onChanged: (task, value) async {
                        setState(() {
                          task.isCompleted = value!;
                        });
                        await SharedPrefService.saveTasks(tasks);
                      },
                      onDelete: (task) async {
                        setState(() {
                          tasks.remove(task);
                        });
                        await SharedPrefService.saveTasks(tasks);
                      },
                    ),
                  ],
                ),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,

        onTap: (index) {
          if (index == 0) return;

          Widget screen;

          switch (index) {
            case 1:
              screen = const TodoScreen();
              break;
            case 2:
              screen = const CompletedScreen();
              break;
            case 3:
              screen = const ProfileScreen();
              break;
            default:
              screen = const HomeScreen();
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => screen,
            ),
          );
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            activeIcon: Icon(Icons.note_alt),
            label: "To Do",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            activeIcon: Icon(Icons.check_circle),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),

    );
  }
}