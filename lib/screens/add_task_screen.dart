import 'package:flutter/material.dart';
import 'package:projj/screens/shared_pref_service.dart';
import 'package:projj/screens/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  // ===========================
  // Form Key
  // ===========================

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // ===========================
  // Text Controllers
  // ===========================

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  // ===========================
  // Switch Value
  // ===========================

  bool isHighPriority = false;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // ===========================
      // Background Color
      // ===========================

      backgroundColor: Colors.white,

      // ===========================
      // App Bar
      // ===========================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "New Task",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),

      body: Form(
        key: formKey,

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // ===========================
              // Task Name
              // ===========================

              const Text(
                "Task Name",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(

                controller: titleController,

                validator: (value){

                  if(value==null || value.trim().isEmpty){
                    return "Please Enter Task Name";
                  }

                  return null;

                },

                decoration: InputDecoration(

                  hintText: "Enter task name",

                  filled: true,

                  fillColor: Colors.grey.shade100,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ===========================
              // Description
              // ===========================

              const Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              TextFormField(

                controller: descriptionController,

                maxLines: 4,

                validator: (value){

                  if(value==null || value.trim().isEmpty){
                    return "Please Enter Description";
                  }

                  return null;

                },

                decoration: InputDecoration(

                  hintText: "Task description",

                  filled: true,

                  fillColor: Colors.grey.shade100,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ===========================
              // High Priority
              // ===========================

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "High Priority",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Switch(

                    value: isHighPriority,

                    activeColor: Colors.blue,

                    onChanged: (value){

                      setState(() {

                        isHighPriority = value;

                      });

                    },
                  )
                ],
              ),

              const Spacer(),

              // ===========================
              // Add Task Button
              // ===========================

              SizedBox(

                width: double.infinity,

                height: 55,

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.blue,

                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(30),

                    ),
                  ),

                  onPressed: () async {

                    if (formKey.currentState!.validate()) {

                      // إنشاء مهمة جديدة
                      TaskModel task = TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        isHighPriority: isHighPriority,
                      );

                      // قراءة المهام المحفوظة
                      List<TaskModel> tasks =
                      await SharedPrefService.getTasks();

                      // إضافة المهمة الجديدة
                      tasks.add(task);

                      // حفظ القائمة مرة أخرى
                      await SharedPrefService.saveTasks(tasks);

                      // الرجوع إلى الصفحة الرئيسية
                      Navigator.pop(context);
                    }
                  },

                  child: const Text(

                    "Add Task",

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 16,

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}