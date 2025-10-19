import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tasks_provider.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: isWide
          ? GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: tasksProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = tasksProvider.tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.name),
                    subtitle: Text(task.description),
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: tasksProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = tasksProvider.tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    title: Text(task.name),
                    subtitle: Text(task.description),
                  ),
                );
              },
            ),
    );
  }
}
