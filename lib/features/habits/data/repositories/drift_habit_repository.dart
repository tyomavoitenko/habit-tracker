import 'package:drift/drift.dart';
import 'package:habit_tracker/core/database/app_database.dart';
import 'package:habit_tracker/features/habits/domain/entities/check_in.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit.dart';
import 'package:habit_tracker/features/habits/domain/repositories/habit_repository.dart';

class DriftHabitRepository implements HabitRepository {
  DriftHabitRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Habit>> watchHabits() {
    return _db.select(_db.habits).watch().map(
      (rows) => rows.map(_habitFromRow).toList(),
    );
  }

  @override
  Future<Habit> createHabit(String name) async {
    final createdAt = DateTime.now();
    final id = await _db
        .into(_db.habits)
        .insert(HabitsCompanion.insert(name: name, createdAt: createdAt));
    return Habit(id: id, name: name, createdAt: createdAt);
  }

  @override
  Future<void> deleteHabit(int habitId) {
    return (_db.delete(_db.habits)..where((h) => h.id.equals(habitId))).go();
  }

  @override
  Stream<List<CheckIn>> watchCheckIns(int habitId) {
    final query = _db.select(_db.checkIns)
      ..where((c) => c.habitId.equals(habitId))
      ..orderBy([(c) => OrderingTerm.desc(c.date)]);
    return query.watch().map((rows) => rows.map(_checkInFromRow).toList());
  }

  // insertOrIgnore makes this idempotent: checking in twice on the same day
  // is a no-op rather than a unique-constraint error.
  @override
  Future<void> addCheckIn(int habitId, DateTime date) {
    final day = _dayOf(date);
    return _db
        .into(_db.checkIns)
        .insert(
          CheckInsCompanion.insert(habitId: habitId, date: day),
          mode: InsertMode.insertOrIgnore,
        );
  }

  @override
  Future<void> removeCheckIn(int habitId, DateTime date) {
    final day = _dayOf(date);
    return (_db.delete(_db.checkIns)
          ..where((c) => c.habitId.equals(habitId) & c.date.equals(day)))
        .go();
  }

  Habit _habitFromRow(HabitRow row) =>
      Habit(id: row.id, name: row.name, createdAt: row.createdAt);

  CheckIn _checkInFromRow(CheckInRow row) =>
      CheckIn(id: row.id, habitId: row.habitId, date: row.date);

  DateTime _dayOf(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
