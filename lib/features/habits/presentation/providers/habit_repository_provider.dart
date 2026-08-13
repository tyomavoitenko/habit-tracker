import 'package:habit_tracker/core/database/app_database_provider.dart';
import 'package:habit_tracker/features/habits/data/repositories/drift_habit_repository.dart';
import 'package:habit_tracker/features/habits/domain/repositories/habit_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_repository_provider.g.dart';

@Riverpod(keepAlive: true)
HabitRepository habitRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftHabitRepository(db);
}
