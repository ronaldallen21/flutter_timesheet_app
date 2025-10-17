import 'package:flutter/material.dart';
import '../models/time_entry.dart';
import '../services/database_service.dart';

class TimeEntriesProvider extends ChangeNotifier {
  List<TimeEntry> _timeEntries = [];
  final DatabaseService _dbService = DatabaseService();

  List<TimeEntry> get timeEntries => _timeEntries;

  TimeEntriesProvider() {
    fetchTimeEntries();
  }

  Future<void> fetchTimeEntries() async {
    _timeEntries = await _dbService.getTimeEntries();
    notifyListeners();
  }

  Future<void> addTimeEntry(TimeEntry entry) async {
    await _dbService.insertTimeEntry(entry);
    await fetchTimeEntries();
  }

  Future<void> updateTimeEntry(TimeEntry entry) async {
    await _dbService.updateTimeEntry(entry);
    await fetchTimeEntries();
  }

  Future<void> deleteTimeEntry(int id) async {
    await _dbService.deleteTimeEntry(id);
    await fetchTimeEntries();
  }

  // Optional: filter by person
  List<TimeEntry> filterByPerson(int personId) {
    return _timeEntries.where((e) => e.personId == personId).toList();
  }

  // Optional: filter by date
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
