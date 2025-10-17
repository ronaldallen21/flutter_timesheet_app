import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/person.dart';
import '../models/task.dart';
import '../models/time_entry.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'timesheet.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE people(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE time_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        personId INTEGER NOT NULL,
        taskId INTEGER NOT NULL,
        date TEXT NOT NULL,
        startTime TEXT NOT NULL,
        endTime TEXT NOT NULL,
        notes TEXT,
        FOREIGN KEY(personId) REFERENCES people(id),
        FOREIGN KEY(taskId) REFERENCES tasks(id)
      )
    ''');

    // Pre-fill people and tasks
    await db.insert('people', {'fullName': 'John Doe'});
    await db.insert('people', {'fullName': 'Jane Smith'});
    await db.insert('tasks', {
      'name': 'Development',
      'description': 'Software development task',
    });
    await db.insert('tasks', {
      'name': 'Testing',
      'description': 'Quality assurance task',
    });
  }

  // CRUD operations for TimeEntry
  Future<int> insertTimeEntry(TimeEntry entry) async {
    final db = await database;
    return await db.insert('time_entries', entry.toMap());
  }

  Future<List<TimeEntry>> getTimeEntries() async {
    final db = await database;
    final result = await db.query('time_entries');
    return result.map((e) => TimeEntry.fromMap(e)).toList();
  }

  Future<int> updateTimeEntry(TimeEntry entry) async {
    final db = await database;
    return await db.update(
      'time_entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> deleteTimeEntry(int id) async {
    final db = await database;
    return await db.delete('time_entries', where: 'id = ?', whereArgs: [id]);
  }

  // Fetch people and tasks
  Future<List<Person>> getPeople() async {
    final db = await database;
    final result = await db.query('people');
    return result.map((e) => Person.fromMap(e)).toList();
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final result = await db.query('tasks');
    return result.map((e) => Task.fromMap(e)).toList();
  }
}
