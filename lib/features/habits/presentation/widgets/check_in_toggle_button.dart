import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habit_repository_provider.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habits_provider.dart';

/// Compact icon button that toggles today's check-in for [habitId].
class CheckInToggleButton extends ConsumerWidget {
  const CheckInToggleButton({required this.habitId, super.key});

  final int habitId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkedInAsync = ref.watch(isHabitCheckedInTodayProvider(habitId));

    return checkedInAsync.when(
      data: (checkedIn) => IconButton(
        onPressed: () => toggleCheckIn(
          context: context,
          ref: ref,
          habitId: habitId,
          isCheckedIn: checkedIn,
        ),
        icon: Icon(
          checkedIn ? Icons.check_circle : Icons.circle_outlined,
          color: checkedIn ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      loading: () => const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, _) => const Icon(Icons.error_outline),
    );
  }
}

/// Adds or removes today's check-in for [habitId], depending on
/// [isCheckedIn]. Shared by [CheckInToggleButton] and the habit detail
/// screen's larger call-to-action button so the toggle logic lives in one
/// place.
Future<void> toggleCheckIn({
  required BuildContext context,
  required WidgetRef ref,
  required int habitId,
  required bool isCheckedIn,
}) async {
  final repository = ref.read(habitRepositoryProvider);
  final today = DateTime.now();
  try {
    if (isCheckedIn) {
      await repository.removeCheckIn(habitId, today);
    } else {
      await repository.addCheckIn(habitId, today);
    }
  } on Exception catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong: $e')));
    }
  }
}
