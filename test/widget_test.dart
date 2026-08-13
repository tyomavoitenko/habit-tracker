import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/app/app.dart';
import 'package:habit_tracker/core/database/app_database.dart';
import 'package:habit_tracker/core/database/app_database_provider.dart';

void main() {
  testWidgets('app boots and shows an empty state when there are no habits', (
    tester,
  ) async {
    // closeStreamsSynchronously avoids a pending-timer assertion:
    // Drift normally waits one event loop turn before tearing down a
    // cancelled query stream (to dedupe StreamBuilder-style reconnects),
    // which trips flutter_test's "no timers left after the test" check.
    final db = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    addTearDown(db.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const HabitTrackerApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Habits'), findsOneWidget);
    expect(find.text('No habits yet'), findsOneWidget);
  });
}
