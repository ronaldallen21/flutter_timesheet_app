class Person {
  final int id;
  final String fullName;

  Person({required this.id, required this.fullName});

  Map<String, dynamic> toMap() {
    return {'id': id, 'fullName': fullName};
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(id: map['id'], fullName: map['fullName']);
  }
}
