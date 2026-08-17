import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit.dart';
import 'package:habit_tracker/features/habits/presentation/widgets/check_in_toggle_button.dart';

class HabitListTile extends ConsumerWidget {
  const HabitListTile({required this.habit, super.key});

  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(habit.name),
      onTap: () => context.push('/habits/${habit.id}', extra: habit),
      trailing: CheckInToggleButton(habitId: habit.id),
    );
  }
}
