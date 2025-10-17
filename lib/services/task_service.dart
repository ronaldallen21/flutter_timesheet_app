import 'package:flutter/material.dart';
import 'package:flutter_timesheet_app/utils/helper.dart';
import '../models/task.dart';
import 'database_service.dart';

class TasksService {
  final dbService = DatabaseService();

  Future<List<Task>> getTasks({BuildContext? context}) async {
    return await AppHelper.handleAsync<List<Task>>(
          context: context,
          errorMessage: 'Failed to load tasks',
          fallback: [],
          operation: () async {
            final db = await dbService.database;
            final result = await db.query('tasks');
            return result.map((e) => Task.fromMap(e)).toList();
          },
        ) ??
        [];
  }
}
