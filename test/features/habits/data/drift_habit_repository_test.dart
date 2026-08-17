import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/core/database/app_database.dart';
import 'package:habit_tracker/features/habits/data/repositories/drift_habit_repository.dart';

void main() {
  late AppDatabase db;
  late DriftHabitRepository repository;

  setUp(() {
    db = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    repository = DriftHabitRepository(db);
  });

  tearDown(() => db.close());

  group('habits', () {
    test('createHabit is reflected in watchHabits', () async {
      final created = await repository.createHabit('Meditate');

      final habits = await repository.watchHabits().first;

      expect(habits, hasLength(1));
      expect(habits.single.id, created.id);
      expect(habits.single.name, 'Meditate');
    });

    test('updateHabit changes the stored name', () async {
      final habit = await repository.createHabit('Meditate');

      await repository.updateHabit(habit.id, 'Meditate 10 minutes');

      final habits = await repository.watchHabits().first;
      expect(habits.single.name, 'Meditate 10 minutes');
    });

    test('deleteHabit cascades to its check-ins', () async {
      final habit = await repository.createHabit('Meditate');
      await repository.addCheckIn(habit.id, DateTime(2026, 8, 17));

      await repository.deleteHabit(habit.id);

      final habits = await repository.watchHabits().first;
      expect(habits, isEmpty);

      final remainingCheckIns = await db.select(db.checkIns).get();
      expect(remainingCheckIns, isEmpty);
    });
  });

  group('check-ins', () {
    test('addCheckIn is reflected in watchCheckIns', () async {
      final habit = await repository.createHabit('Meditate');

      await repository.addCheckIn(habit.id, DateTime(2026, 8, 17));

      final checkIns = await repository.watchCheckIns(habit.id).first;
      expect(checkIns, hasLength(1));
      expect(checkIns.single.date, DateTime(2026, 8, 17));
    });

    test('addCheckIn truncates the time-of-day component', () async {
      final habit = await repository.createHabit('Meditate');

      await repository.addCheckIn(habit.id, DateTime(2026, 8, 17, 22, 30));

      final checkIns = await repository.watchCheckIns(habit.id).first;
      expect(checkIns.single.date, DateTime(2026, 8, 17));
    });

    test('addCheckIn twice on the same day is idempotent', () async {
      final habit = await repository.createHabit('Meditate');

      await repository.addCheckIn(habit.id, DateTime(2026, 8, 17, 8));
      await repository.addCheckIn(habit.id, DateTime(2026, 8, 17, 20));

      final checkIns = await repository.watchCheckIns(habit.id).first;
      expect(checkIns, hasLength(1));
    });

    test('removeCheckIn deletes only the matching day', () async {
      final habit = await repository.createHabit('Meditate');
      await repository.addCheckIn(habit.id, DateTime(2026, 8, 16));
      await repository.addCheckIn(habit.id, DateTime(2026, 8, 17));

      await repository.removeCheckIn(habit.id, DateTime(2026, 8, 17));

      final checkIns = await repository.watchCheckIns(habit.id).first;
      expect(checkIns, hasLength(1));
      expect(checkIns.single.date, DateTime(2026, 8, 16));
    });

    test('watchCheckIns orders by date descending', () async {
      final habit = await repository.createHabit('Meditate');
      await repository.addCheckIn(habit.id, DateTime(2026, 8, 15));
      await repository.addCheckIn(habit.id, DateTime(2026, 8, 17));
      await repository.addCheckIn(habit.id, DateTime(2026, 8, 16));

      final checkIns = await repository.watchCheckIns(habit.id).first;

      expect(checkIns.map((c) => c.date), [
        DateTime(2026, 8, 17),
        DateTime(2026, 8, 16),
        DateTime(2026, 8, 15),
      ]);
    });
  });
}
