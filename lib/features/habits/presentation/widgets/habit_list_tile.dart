import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habits_provider.dart';

class HabitListTile extends ConsumerWidget {
  const HabitListTile({required this.habit, super.key});

  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkedInAsync = ref.watch(isHabitCheckedInTodayProvider(habit.id));

    return ListTile(
      title: Text(habit.name),
      onTap: () => context.push('/habits/${habit.id}/edit', extra: habit),
      trailing: checkedInAsync.when(
        data: (checkedIn) => Icon(
          checkedIn ? Icons.check_circle : Icons.circle_outlined,
          color: checkedIn ? Theme.of(context).colorScheme.primary : null,
        ),
        loading: () => const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        error: (_, _) => const Icon(Icons.error_outline),
      ),
    );
  }
}
