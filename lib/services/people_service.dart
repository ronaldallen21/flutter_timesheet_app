import 'package:flutter/material.dart';
import 'package:flutter_timesheet_app/utils/helper.dart';
import '../models/person.dart';
import 'database_service.dart';

class PeopleService {
  final dbService = DatabaseService();

  Future<List<Person>> getPeople({BuildContext? context}) async {
    return await AppHelper.handleAsync<List<Person>>(
          context: context,
          errorMessage: 'Failed to load people',
          fallback: [],
          operation: () async {
            final db = await dbService.database;
            final result = await db.query('people');
            return result.map((e) => Person.fromMap(e)).toList();
          },
        ) ??
        [];
  }
}
