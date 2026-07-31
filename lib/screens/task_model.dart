
// ===============================
// Task Model
// This class represents one task
// ===============================

class TaskModel {
  // Task title
  String title;

  // Task description
  String description;

  // Is task completed?
  bool isCompleted;

  // Is task high priority?
  bool isHighPriority;

  // Constructor
  TaskModel({
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.isHighPriority = false,
  });

  // ==================================
  // Convert Object to Map
  // ==================================
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "isCompleted": isCompleted,
      "isHighPriority": isHighPriority,
    };
  }

  // ==================================
  // Create Object From Map
  // ==================================
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map["title"],
      description: map["description"],
      isCompleted: map["isCompleted"],
      isHighPriority: map["isHighPriority"],
    );
  }

  // ==================================
  // Convert Object to Json
  // ==================================
  Map<String, dynamic> toJson() {
    return toMap();
  }

  // ==================================
  // Create Object From Json
  // ==================================
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel.fromMap(json);
  }
}