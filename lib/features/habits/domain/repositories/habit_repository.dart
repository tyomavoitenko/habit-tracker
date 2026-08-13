import 'package:habit_tracker/features/habits/domain/entities/check_in.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit.dart';

/// Abstracts persistence for habits and their check-ins.
///
/// A [CheckIn] has no lifecycle of its own — it only ever exists attached to
/// a habit — so both are owned by this single repository rather than split
/// across two.
abstract class HabitRepository {
  Stream<List<Habit>> watchHabits();

  Future<Habit> createHabit(String name);

  Future<void> updateHabit(int habitId, String name);

  Future<void> deleteHabit(int habitId);

  Stream<List<CheckIn>> watchCheckIns(int habitId);

  Future<void> addCheckIn(int habitId, DateTime date);

  Future<void> removeCheckIn(int habitId, DateTime date);
}
