import 'package:drift/drift.dart';
import 'package:habit_tracker/features/habits/data/tables/habits_table.dart';

@DataClassName('CheckInRow')
class CheckIns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId =>
      integer().references(Habits, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();

  // A habit can only be checked in once per calendar day.
  @override
  List<Set<Column>> get uniqueKeys => [
    {habitId, date},
  ];
}
