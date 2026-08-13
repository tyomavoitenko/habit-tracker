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
}
