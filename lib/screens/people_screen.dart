import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/people_provider.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final peopleProvider = Provider.of<PeopleProvider>(context);
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('People')),
      body: isWide
          ? GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: peopleProvider.people.length,
              itemBuilder: (context, index) {
                final person = peopleProvider.people[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(child: Text(person.fullName[0])),
                    title: Text(person.fullName),
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: peopleProvider.people.length,
              itemBuilder: (context, index) {
                final person = peopleProvider.people[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(person.fullName[0])),
                    title: Text(person.fullName),
                  ),
                );
              },
            ),
    );
  }
}
