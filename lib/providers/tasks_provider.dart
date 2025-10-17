import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  final DatabaseService _dbService = DatabaseService();

  List<Task> get tasks => _tasks;

  TasksProvider() {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    _tasks = await _dbService.getTasks();
    notifyListeners();
  }

  Task? getTaskById(int id) {
    return _tasks.firstWhere(
      (t) => t.id == id,
      orElse: () => Task(id: 0, name: 'Unknown', description: ''),
    );
  }
}
