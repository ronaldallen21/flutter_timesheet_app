import 'package:flutter/material.dart';
import '../models/person.dart';
import '../services/database_service.dart';

class PeopleProvider extends ChangeNotifier {
  List<Person> _people = [];
  final DatabaseService _dbService = DatabaseService();

  List<Person> get people => _people;

  PeopleProvider() {
    fetchPeople();
  }

  Future<void> fetchPeople() async {
    _people = await _dbService.getPeople();
    notifyListeners();
  }

  Person? getPersonById(int id) {
    return _people.firstWhere(
      (p) => p.id == id,
      orElse: () => Person(id: 0, fullName: 'Unknown'),
    );
  }
}
