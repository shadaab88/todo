

class TaskDataResponse {
  TaskDataResponse({
    this.id,
    this.userId,
    this.taskName,
    this.taskDescription,
    this.taskDate,
    this.taskTime,
  });

  String? id;
  String? userId;
  String? taskName;
  String? taskDescription;
  String? taskDate;
  String? taskTime;



  factory TaskDataResponse.fromJson(Map<String, dynamic> json) => TaskDataResponse(
    id: json['id'] ?? "",
    userId: json['user_id'] ?? "",
    taskName: json['task_name'] ?? "",
    taskDescription: json['task_description'] ?? "",
    taskDate: json['task_date'] ?? "",
    taskTime: json['task_time'] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    'user_id': userId,
    "task_name": taskName,
    "task_description": taskDescription,
    "task_date": taskDate,
    "task_time": taskTime,
  };
}