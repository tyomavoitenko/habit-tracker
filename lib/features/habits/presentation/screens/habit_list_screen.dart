import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habits_provider.dart';
import 'package:habit_tracker/features/habits/presentation/widgets/habit_list_tile.dart';

class HabitListScreen extends ConsumerWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      body: habitsAsync.when(
        data: (habits) {
          if (habits.isEmpty) {
            return const Center(child: Text('No habits yet'));
          }
          return ListView.builder(
            itemCount: habits.length,
            itemBuilder: (context, index) =>
                HabitListTile(habit: habits[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Something went wrong: $error')),
      ),
    );
  }
}
