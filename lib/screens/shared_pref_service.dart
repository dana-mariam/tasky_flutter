import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'task_model.dart';

// ======================================
// SharedPreferences Service
// ======================================

class SharedPrefService {
  // المفتاح الذي سنحفظ تحته قائمة المهام
  static const String taskKey = "tasks";

  // ======================================
  // Save Tasks
  // ======================================

  static Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    // تحويل كل Task إلى Json
    List<Map<String, dynamic>> taskList =
    tasks.map((task) => task.toJson()).toList();

    // تحويل القائمة إلى String
    String jsonString = jsonEncode(taskList);

    // حفظها داخل SharedPreferences
    await prefs.setString(taskKey, jsonString);
  }
  static Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // ======================================
  // Get Tasks
  // ======================================

  static Future<List<TaskModel>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString(taskKey);



    // إذا لم توجد بيانات
    if (jsonString == null) {
      return [];
    }

    // تحويل الـ String إلى List
    List decodedData = jsonDecode(jsonString);

    // تحويل الـ List إلى List<TaskModel>
    return decodedData
        .map((task) => TaskModel.fromJson(task))
        .toList();
  }
}