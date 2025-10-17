import 'package:flutter/material.dart';
import 'people_screen.dart';
import 'tasks_screen.dart';
import 'time_entry_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Timesheet App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildMenuButton(context, 'People', PeopleScreen()),
            _buildMenuButton(context, 'Tasks', TasksScreen()),
            _buildMenuButton(context, 'Time Entries', TimeEntryScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
        child: SizedBox(
          width: double.infinity,
          child: Center(child: Text(title)),
        ),
      ),
    );
  }
}
