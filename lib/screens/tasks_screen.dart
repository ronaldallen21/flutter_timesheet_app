import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: ListView.builder(
        itemCount: tasksProvider.tasks.length,
        itemBuilder: (context, index) {
          final task = tasksProvider.tasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text(task.description),
          );
        },
      ),
    );
  }
}
