import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/app/app.dart';
import 'package:habit_tracker/core/database/app_database.dart';
import 'package:habit_tracker/core/database/app_database_provider.dart';
import 'package:habit_tracker/features/habits/data/repositories/drift_habit_repository.dart';

AppDatabase _inMemoryDatabase() {
  // closeStreamsSynchronously avoids a pending-timer assertion: Drift
  // normally waits one event loop turn before tearing down a cancelled
  // query stream (to dedupe StreamBuilder-style reconnects), which trips
  // flutter_test's "no timers left after the test" check.
  return AppDatabase(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
}

Future<void> _pumpApp(WidgetTester tester, AppDatabase db) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: const HabitTrackerApp(),
    ),
  );
}

void main() {
  testWidgets('shows an empty state when there are no habits', (
    tester,
  ) async {
    final db = _inMemoryDatabase();
    addTearDown(db.close);

    await _pumpApp(tester, db);
    await tester.pumpAndSettle();

    expect(find.text('Habits'), findsOneWidget);
    expect(find.text('No habits yet'), findsOneWidget);
  });

  testWidgets('shows existing habits from the repository', (tester) async {
    final db = _inMemoryDatabase();
    addTearDown(db.close);
    await DriftHabitRepository(db).createHabit('Meditate');

    await _pumpApp(tester, db);
    await tester.pumpAndSettle();

    expect(find.text('Meditate'), findsOneWidget);
    expect(find.text('No habits yet'), findsNothing);
  });

  testWidgets('tapping the FAB opens the add habit form', (tester) async {
    final db = _inMemoryDatabase();
    addTearDown(db.close);

    await _pumpApp(tester, db);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('New habit'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Habit name'), findsOneWidget);
  });
}
