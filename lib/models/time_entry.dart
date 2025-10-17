class TimeEntry {
  final int? id;
  final int personId;
  final int taskId;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;

  TimeEntry({
    this.id,
    required this.personId,
    required this.taskId,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'personId': personId,
      'taskId': taskId,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'notes': notes,
    };
  }

  factory TimeEntry.fromMap(Map<String, dynamic> map) {
    return TimeEntry(
      id: map['id'],
      personId: map['personId'],
      taskId: map['taskId'],
      date: DateTime.parse(map['date']),
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      notes: map['notes'],
    );
  }
}
