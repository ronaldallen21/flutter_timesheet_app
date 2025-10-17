import 'package:flutter/material.dart';
import 'package:flutter_timesheet_app/services/time_entries_service.dart';
import '../models/time_entry.dart';

class TimeEntriesProvider extends ChangeNotifier {
  List<TimeEntry> _timeEntries = [];
  final TimeEntriesService _timeEntriesService = TimeEntriesService();

  List<TimeEntry> get timeEntries => _timeEntries;

  TimeEntriesProvider() {
    fetchTimeEntries();
  }

  Future<void> fetchTimeEntries() async {
    _timeEntries = await _timeEntriesService.getTimeEntries();
    notifyListeners();
  }

  Future<void> addTimeEntry(TimeEntry entry) async {
    await _timeEntriesService.addTimeEntry(entry);
    await fetchTimeEntries();
  }

  Future<void> updateTimeEntry(TimeEntry entry) async {
    await _timeEntriesService.updateTimeEntry(entry);
    await fetchTimeEntries();
  }

  Future<void> deleteTimeEntry(int id) async {
    await _timeEntriesService.deleteTimeEntry(id);
    await fetchTimeEntries();
  }

  List<TimeEntry> filterByPerson(int personId) {
    return _timeEntries.where((e) => e.personId == personId).toList();
  }

  List<TimeEntry> filterByDate(DateTime date) {
    return _timeEntries
        .where(
          (e) =>
              e.date.year == date.year &&
              e.date.month == date.month &&
              e.date.day == date.day,
        )
        .toList();
  }
}
