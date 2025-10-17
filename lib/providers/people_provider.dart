import 'package:flutter/material.dart';
import 'package:flutter_timesheet_app/services/people_service.dart';
import '../models/person.dart';

class PeopleProvider extends ChangeNotifier {
  List<Person> _people = [];
  final PeopleService _peopleService = PeopleService();

  List<Person> get people => _people;

  PeopleProvider() {
    fetchPeople();
  }

  Future<void> fetchPeople() async {
    _people = await _peopleService.getPeople();
    notifyListeners();
  }

  Person? getPersonById(int id) {
    return _people.firstWhere(
      (p) => p.id == id,
      orElse: () => Person(id: 0, fullName: 'Unknown'),
    );
  }
}
