import 'package:flutter/material.dart';
import 'package:flutter_timesheet_app/services/task_service.dart';
import '../models/task.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  final TasksService _tasksService = TasksService();

  List<Task> get tasks => _tasks;

  TasksProvider() {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    _tasks = await _tasksService.getTasks();
    notifyListeners();
  }

  Task? getTaskById(int id) {
    return _tasks.firstWhere(
      (t) => t.id == id,
      orElse: () => Task(id: 0, name: 'Unknown', description: ''),
    );
  }
}
