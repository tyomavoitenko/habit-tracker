import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:habit_tracker/features/habits/data/tables/check_ins_table.dart';
import 'package:habit_tracker/features/habits/data/tables/habits_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Habits, CheckIns])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'habit_tracker'));

  @override
  int get schemaVersion => 1;

  // SQLite has foreign key enforcement off by default per-connection, so
  // CheckIns.habitId's onDelete: cascade silently does nothing unless this
  // is turned on for every connection we open.
  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
