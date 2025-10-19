import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/time_entries_provider.dart';
import '../providers/people_provider.dart';
import '../providers/tasks_provider.dart';
import '../models/time_entry.dart';
import 'time_entry_form_screen.dart';

class TimeEntryScreen extends StatefulWidget {
  const TimeEntryScreen({super.key});

  @override
  TimeEntryScreenState createState() => TimeEntryScreenState();
}

class TimeEntryScreenState extends State<TimeEntryScreen> {
  int? _selectedPersonId;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<TimeEntriesProvider>(context);
    final peopleProvider = Provider.of<PeopleProvider>(context);
    final tasksProvider = Provider.of<TasksProvider>(context);
    final isWide = MediaQuery.of(context).size.width > 600;

    List<TimeEntry> filteredEntries = timeProvider.timeEntries;
    if (_selectedPersonId != null) {
      filteredEntries = filteredEntries
          .where((e) => e.personId == _selectedPersonId)
          .toList();
    }
    if (_selectedDate != null) {
      filteredEntries = filteredEntries
          .where(
            (e) =>
                e.date.year == _selectedDate!.year &&
                e.date.month == _selectedDate!.month &&
                e.date.day == _selectedDate!.day,
          )
          .toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Time Entries')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                DropdownButton<int>(
                  hint: const Text('Filter by Person'),
                  value: _selectedPersonId,
                  items: [
                    const DropdownMenuItem<int>(
                      value: null,
                      child: Text('All People'),
                    ),
                    ...peopleProvider.people.map(
                      (p) => DropdownMenuItem(
                        value: p.id,
                        child: Text(p.fullName),
                      ),
                    ),
                  ],
                  onChanged: (val) => setState(() => _selectedPersonId = val),
                ),
                ElevatedButton(
                  onPressed: _pickFilterDate,
                  child: Text(
                    _selectedDate == null
                        ? 'All Dates'
                        : _selectedDate!.toLocal().toString().split(' ')[0],
                  ),
                ),
                if (_selectedDate != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => setState(() => _selectedDate = null),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: isWide
                ? GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 600,
                          childAspectRatio: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: filteredEntries.length,
                    itemBuilder: (context, index) {
                      final entry = filteredEntries[index];
                      final person = peopleProvider.getPersonById(
                        entry.personId,
                      );
                      final task = tasksProvider.getTaskById(entry.taskId);
                      return _buildEntryCard(
                        context,
                        entry,
                        person?.fullName ?? '',
                        task?.name ?? '',
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: filteredEntries.length,
                    itemBuilder: (context, index) {
                      final entry = filteredEntries[index];
                      final person = peopleProvider.getPersonById(
                        entry.personId,
                      );
                      final task = tasksProvider.getTaskById(entry.taskId);
                      return _buildEntryCard(
                        context,
                        entry,
                        person?.fullName ?? '',
                        task?.name ?? '',
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Time Entry',
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TimeEntryFormScreen()),
        ),
      ),
    );
  }

  Widget _buildEntryCard(
    BuildContext context,
    TimeEntry entry,
    String personName,
    String taskName,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        title: Text('$personName - $taskName'),
        subtitle: Text(
          'Date: ${entry.date.toLocal().toString().split(' ')[0]}\n'
          'Time: ${TimeOfDay.fromDateTime(entry.startTime).format(context)} - ${TimeOfDay.fromDateTime(entry.endTime).format(context)}\n'
          'Notes: ${entry.notes ?? ''}',
        ),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TimeEntryFormScreen(entry: entry),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final provider = Provider.of<TimeEntriesProvider>(
                  context,
                  listen: false,
                );
                await provider.deleteTimeEntry(entry.id!);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Time entry deleted')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFilterDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }
}
