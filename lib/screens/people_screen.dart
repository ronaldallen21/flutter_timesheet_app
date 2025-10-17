import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/people_provider.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final peopleProvider = Provider.of<PeopleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('People')),
      body: ListView.builder(
        itemCount: peopleProvider.people.length,
        itemBuilder: (context, index) {
          final person = peopleProvider.people[index];
          return ListTile(
            leading: CircleAvatar(child: Text(person.fullName[0])),
            title: Text(person.fullName),
          );
        },
      ),
    );
  }
}
