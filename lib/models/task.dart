class Task {
  final int id;
  final String name;
  final String description;

  Task({required this.id, required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'description': description};
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }
}
