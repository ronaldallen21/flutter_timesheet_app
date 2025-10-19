import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_timesheet_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_timesheet_app/providers/people_provider.dart';
import 'package:flutter_timesheet_app/providers/tasks_provider.dart';
import 'package:flutter_timesheet_app/providers/time_entries_provider.dart';

void main() {
  testWidgets('HomeScreen displays 3 menu cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PeopleProvider()),
          ChangeNotifierProvider(create: (_) => TasksProvider()),
          ChangeNotifierProvider(create: (_) => TimeEntriesProvider()),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('People'), findsOneWidget);
    expect(find.text('Tasks'), findsOneWidget);
    expect(find.text('Time Entries'), findsOneWidget);

    await tester.tap(find.text('People'));
    await tester.pumpAndSettle();

    expect(find.text('People'), findsWidgets);
  });
}
