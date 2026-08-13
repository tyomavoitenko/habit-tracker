import 'package:habit_tracker/features/habits/domain/entities/habit.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habit_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habits_provider.g.dart';

@riverpod
Stream<List<Habit>> habits(Ref ref) {
  final repository = ref.watch(habitRepositoryProvider);
  return repository.watchHabits();
}

@riverpod
Stream<bool> isHabitCheckedInToday(Ref ref, int habitId) {
  final repository = ref.watch(habitRepositoryProvider);
  final today = DateTime.now();
  return repository
      .watchCheckIns(habitId)
      .map((checkIns) => checkIns.any((c) => _isSameDay(c.date, today)));
}

bool _isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;
