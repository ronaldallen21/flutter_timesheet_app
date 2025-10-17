import 'package:flutter/material.dart';
import 'package:flutter_timesheet_app/utils/helper.dart';
import '../models/time_entry.dart';
import 'database_service.dart';

class TimeEntriesService {
  final dbService = DatabaseService();

  Future<List<TimeEntry>> getTimeEntries({BuildContext? context}) async {
    return await AppHelper.handleAsync<List<TimeEntry>>(
          context: context,
          errorMessage: 'Failed to load time entries',
          fallback: [],
          operation: () async {
            final db = await dbService.database;
            final result = await db.query('time_entries');
            return result.map((e) => TimeEntry.fromMap(e)).toList();
          },
        ) ??
        [];
  }

  Future<int?> addTimeEntry(TimeEntry entry, {BuildContext? context}) async {
    return await AppHelper.handleAsync<int>(
      context: context,
      errorMessage: 'Failed to add time entry',
      operation: () async {
        final db = await dbService.database;
        return await db.insert('time_entries', entry.toMap());
      },
    );
  }

  Future<int?> updateTimeEntry(TimeEntry entry, {BuildContext? context}) async {
    return await AppHelper.handleAsync<int>(
      context: context,
      errorMessage: 'Failed to update time entry',
      operation: () async {
        final db = await dbService.database;
        return await db.update(
          'time_entries',
          entry.toMap(),
          where: 'id = ?',
          whereArgs: [entry.id],
        );
      },
    );
  }

  Future<int?> deleteTimeEntry(int id, {BuildContext? context}) async {
    return await AppHelper.handleAsync<int>(
      context: context,
      errorMessage: 'Failed to delete time entry',
      operation: () async {
        final db = await dbService.database;
        return await db.delete(
          'time_entries',
          where: 'id = ?',
          whereArgs: [id],
        );
      },
    );
  }
}
