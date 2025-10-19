import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/time_entry.dart';
import '../providers/people_provider.dart';
import '../providers/tasks_provider.dart';
import '../providers/time_entries_provider.dart';

class TimeEntryFormScreen extends StatefulWidget {
  final TimeEntry? entry;
  const TimeEntryFormScreen({super.key, this.entry});

  @override
  TimeEntryFormScreenState createState() => TimeEntryFormScreenState();
}

class TimeEntryFormScreenState extends State<TimeEntryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedPersonId;
  int? _selectedTaskId;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _notes;

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _selectedPersonId = widget.entry!.personId;
      _selectedTaskId = widget.entry!.taskId;
      _selectedDate = widget.entry!.date;
      _startTime = TimeOfDay.fromDateTime(widget.entry!.startTime);
      _endTime = TimeOfDay.fromDateTime(widget.entry!.endTime);
      _notes = widget.entry!.notes;
    }
  }

  @override
  Widget build(BuildContext context) {
    final peopleProvider = Provider.of<PeopleProvider>(context);
    final tasksProvider = Provider.of<TasksProvider>(context);
    final timeProvider = Provider.of<TimeEntriesProvider>(context);
    final isWide = MediaQuery.of(context).size.width > 600;

    Widget formContent = Column(
      children: [
        DropdownButtonFormField<int>(
          initialValue: _selectedPersonId,
          decoration: const InputDecoration(labelText: 'Person'),
          items: peopleProvider.people
              .map(
                (p) => DropdownMenuItem(value: p.id, child: Text(p.fullName)),
              )
              .toList(),
          onChanged: (val) => setState(() => _selectedPersonId = val),
          validator: (val) => val == null ? 'Please select a person' : null,
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<int>(
          initialValue: _selectedTaskId,
          decoration: const InputDecoration(labelText: 'Task'),
          items: tasksProvider.tasks
              .map((t) => DropdownMenuItem(value: t.id, child: Text(t.name)))
              .toList(),
          onChanged: (val) => setState(() => _selectedTaskId = val),
          validator: (val) => val == null ? 'Please select a task' : null,
        ),
        const SizedBox(height: 16),
        ListTile(
          title: Text(
            'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
          ),
          trailing: const Icon(Icons.calendar_today),
          onTap: _pickDate,
        ),
        ListTile(
          title: Text('Start Time: ${_startTime?.format(context) ?? 'Select'}'),
          trailing: const Icon(Icons.access_time),
          onTap: _pickStartTime,
        ),
        ListTile(
          title: Text('End Time: ${_endTime?.format(context) ?? 'Select'}'),
          trailing: const Icon(Icons.access_time),
          onTap: _pickEndTime,
        ),
        const SizedBox(height: 16),
        TextFormField(
          initialValue: _notes,
          decoration: const InputDecoration(labelText: 'Notes (Optional)'),
          maxLines: 3,
          onChanged: (val) => _notes = val,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.entry == null ? 'Add Time Entry' : 'Edit Time Entry',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: formContent),
                    const SizedBox(width: 24),
                    Expanded(child: Container()),
                  ],
                )
              : ListView(children: [formContent]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(widget.entry == null ? 'Add Entry' : 'Update Entry'),
        icon: const Icon(Icons.save),
        onPressed: () async {
          if (!_formKey.currentState!.validate()) return;
          if (_startTime == null || _endTime == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select start and end time')),
            );
            return;
          }

          final startDateTime = DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _startTime!.hour,
            _startTime!.minute,
          );
          final endDateTime = DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _endTime!.hour,
            _endTime!.minute,
          );
          if (endDateTime.isBefore(startDateTime)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('End time must be after start time'),
              ),
            );
            return;
          }

          final entry = TimeEntry(
            id: widget.entry?.id,
            personId: _selectedPersonId!,
            taskId: _selectedTaskId!,
            date: _selectedDate,
            startTime: startDateTime,
            endTime: endDateTime,
            notes: _notes,
          );

          if (widget.entry == null) {
            await timeProvider.addTimeEntry(entry);
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Time entry added')));
            }
          } else {
            await timeProvider.updateTimeEntry(entry);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Time entry updated')),
              );
            }
          }
          if (context.mounted) Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _startTime = picked);
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _endTime = picked);
  }
}
