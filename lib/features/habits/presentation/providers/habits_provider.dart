import 'package:habit_tracker/features/habits/domain/entities/check_in.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit.dart';
import 'package:habit_tracker/features/habits/domain/streak_calculator.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habit_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habits_provider.g.dart';

@riverpod
Stream<List<Habit>> habits(Ref ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return repository.watchHabits();
}

@riverpod
Stream<List<CheckIn>> habitCheckIns(Ref ref, int habitId) {
  final repository = ref.watch(habitRepositoryProvider);
  return repository.watchCheckIns(habitId);
}

@riverpod
AsyncValue<bool> isHabitCheckedInToday(Ref ref, int habitId) {
  final today = DateTime.now();
  return ref
      .watch(habitCheckInsProvider(habitId))
      .whenData((checkIns) => checkIns.any((c) => _isSameDay(c.date, today)));
}

@riverpod
AsyncValue<int> currentStreak(Ref ref, int habitId) {
  return ref
      .watch(habitCheckInsProvider(habitId))
      .whenData(
        (checkIns) => calculateCurrentStreak(
          checkIns.map((c) => c.date).toList(),
          today: DateTime.now(),
        ),
      );
}

bool _isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;
