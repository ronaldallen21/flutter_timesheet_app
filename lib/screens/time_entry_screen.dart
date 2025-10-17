import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/time_entries_provider.dart';
import '../providers/people_provider.dart';
import '../providers/tasks_provider.dart';
import '../models/time_entry.dart';
import 'time_entry_form_screen.dart';

class TimeEntryScreen extends StatefulWidget {
  @override
  _TimeEntryScreenState createState() => _TimeEntryScreenState();
}

class _TimeEntryScreenState extends State<TimeEntryScreen> {
  int? _selectedPersonId;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<TimeEntriesProvider>(context);
    final peopleProvider = Provider.of<PeopleProvider>(context);
    final tasksProvider = Provider.of<TasksProvider>(context);

    // Apply filtering
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
      appBar: AppBar(title: Text('Time Entries')),
      body: Column(
        children: [
          // Filter Row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Person Filter Dropdown
                Expanded(
                  child: DropdownButton<int>(
                    hint: Text('Filter by Person'),
                    value: _selectedPersonId,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem<int>(
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
                    onChanged: (val) {
                      setState(() {
                        _selectedPersonId = val;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                // Date Filter
                ElevatedButton(
                  child: Text(
                    _selectedDate == null
                        ? 'All Dates'
                        : _selectedDate!.toLocal().toString().split(' ')[0],
                  ),
                  onPressed: _pickFilterDate,
                ),
                SizedBox(width: 8),
                if (_selectedDate != null)
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => setState(() => _selectedDate = null),
                  ),
              ],
            ),
          ),
          Divider(height: 1),

          // Entries List
          Expanded(
            child: ListView.builder(
              itemCount: filteredEntries.length,
              itemBuilder: (context, index) {
                final entry = filteredEntries[index];
                final person = peopleProvider.getPersonById(entry.personId);
                final task = tasksProvider.getTaskById(entry.taskId);

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text('${person?.fullName} - ${task?.name}'),
                    subtitle: Text(
                      'Date: ${entry.date.toLocal().toString().split(' ')[0]}\n'
                      'Time: ${entry.startTime.hour}:${entry.startTime.minute} - ${entry.endTime.hour}:${entry.endTime.minute}\n'
                      'Notes: ${entry.notes ?? ''}',
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TimeEntryFormScreen(entry: entry),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await timeProvider.deleteTimeEntry(entry.id!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Time entry deleted')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TimeEntryFormScreen()),
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
