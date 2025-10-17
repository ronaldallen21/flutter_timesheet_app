import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_timesheet_app/models/time_entry.dart';
import 'package:flutter_timesheet_app/providers/time_entries_provider.dart';

void main() {
  group('TimeEntriesProvider Tests', () {
    late TimeEntriesProvider provider;

    setUp(() {
      provider = TimeEntriesProvider();
    });

    test('Add a time entry', () {
      final entry = TimeEntry(
        id: 1,
        personId: 1,
        taskId: 1,
        date: DateTime(2025, 10, 17),
        startTime: DateTime(2025, 10, 17, 9, 0),
        endTime: DateTime(2025, 10, 17, 10, 0),
        notes: 'Test entry',
      );

      provider.addTimeEntry(entry);

      expect(provider.timeEntries.length, 1);
      expect(provider.timeEntries.first.notes, 'Test entry');
    });

    test('Update a time entry', () {
      final entry = TimeEntry(
        id: 1,
        personId: 1,
        taskId: 1,
        date: DateTime(2025, 10, 17),
        startTime: DateTime(2025, 10, 17, 9, 0),
        endTime: DateTime(2025, 10, 17, 10, 0),
        notes: 'Test entry',
      );
      provider.addTimeEntry(entry);

      final updatedEntry = TimeEntry(
        id: 1,
        personId: 1,
        taskId: 1,
        date: DateTime(2025, 10, 17),
        startTime: DateTime(2025, 10, 17, 9, 30),
        endTime: DateTime(2025, 10, 17, 10, 30),
        notes: 'Updated entry',
      );

      provider.updateTimeEntry(updatedEntry);

      expect(provider.timeEntries.first.notes, 'Updated entry');
      expect(provider.timeEntries.first.startTime.hour, 9);
      expect(provider.timeEntries.first.startTime.minute, 30);
    });
  });
}
