import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habits_provider.dart';
import 'package:habit_tracker/features/habits/presentation/widgets/habit_list_tile.dart';

void main() {
  final habit = Habit(id: 1, name: 'Meditate', createdAt: DateTime(2026));

  Future<void> pumpTile(WidgetTester tester, {required bool checkedIn}) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [
          isHabitCheckedInTodayProvider(
            habit.id,
          ).overrideWithValue(AsyncData(checkedIn)),
        ],
        child: MaterialApp(home: Scaffold(body: HabitListTile(habit: habit))),
      ),
    );
  }

  testWidgets('unchecked state matches golden file', (tester) async {
    await pumpTile(tester, checkedIn: false);
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HabitListTile),
      matchesGoldenFile('goldens/habit_list_tile_unchecked.png'),
    );
  });

  testWidgets('checked-in state matches golden file', (tester) async {
    await pumpTile(tester, checkedIn: true);
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(HabitListTile),
      matchesGoldenFile('goldens/habit_list_tile_checked.png'),
    );
  });
}
