import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/features/habits/domain/entities/check_in.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habits_provider.dart';
import 'package:habit_tracker/features/habits/presentation/widgets/check_in_toggle_button.dart';

class HabitDetailScreen extends ConsumerWidget {
  const HabitDetailScreen({required this.habit, super.key});

  final Habit habit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(currentStreakProvider(habit.id));
    final checkedInTodayAsync = ref.watch(
      isHabitCheckedInTodayProvider(habit.id),
    );
    final checkInsAsync = ref.watch(habitCheckInsProvider(habit.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
        actions: [
          IconButton(
            onPressed: () =>
                context.push('/habits/${habit.id}/edit', extra: habit),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            streakAsync.when(
              data: (streak) => Text(
                streak == 0 ? 'No current streak' : '$streak day streak',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            checkedInTodayAsync.when(
              data: (checkedIn) => FilledButton.icon(
                onPressed: () => toggleCheckIn(
                  context: context,
                  ref: ref,
                  habitId: habit.id,
                  isCheckedIn: checkedIn,
                ),
                icon: Icon(
                  checkedIn ? Icons.check_circle : Icons.circle_outlined,
                ),
                label: Text(
                  checkedIn ? 'Checked in today' : 'Mark today done',
                ),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            Text(
              'Last 14 days',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            checkInsAsync.when(
              data: (checkIns) => _HistoryRow(checkIns: checkIns),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Text('Something went wrong: $error'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.checkIns});

  final List<CheckIn> checkIns;

  @override
  Widget build(BuildContext context) {
    final checkedDays = checkIns.map((c) => _dayOnly(c.date)).toSet();
    final today = _dayOnly(DateTime.now());
    final days = List.generate(
      14,
      (i) => today.subtract(Duration(days: 13 - i)),
    );

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final day in days)
          Tooltip(
            message: '${day.month}/${day.day}',
            child: CircleAvatar(
              radius: 12,
              backgroundColor: checkedDays.contains(day)
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
      ],
    );
  }

  DateTime _dayOnly(DateTime date) => DateTime(date.year, date.month, date.day);
}
