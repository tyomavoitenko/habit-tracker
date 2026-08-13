import 'package:meta/meta.dart';

/// A single day's completion record for a habit.
///
/// The `date` field is always truncated to midnight in the local timezone —
/// a "day" for streak purposes is the device's local calendar day, not a
/// rolling 24h window.
@immutable
class CheckIn {
  const CheckIn({required this.id, required this.habitId, required this.date});

  final int id;
  final int habitId;
  final DateTime date;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckIn &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          habitId == other.habitId &&
          date == other.date;

  @override
  int get hashCode => Object.hash(id, habitId, date);
}
