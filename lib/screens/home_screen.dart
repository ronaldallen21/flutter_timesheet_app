import 'package:flutter/material.dart';
import 'people_screen.dart';
import 'tasks_screen.dart';
import 'time_entry_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Timesheet App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: isWide ? 3 : 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildMenuCard(
              context,
              'People',
              Icons.person,
              const PeopleScreen(),
            ),
            _buildMenuCard(context, 'Tasks', Icons.task, const TasksScreen()),
            _buildMenuCard(
              context,
              'Time Entries',
              Icons.access_time,
              const TimeEntryScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Theme.of(context).primaryColor),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
