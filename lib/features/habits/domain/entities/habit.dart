import 'package:meta/meta.dart';

/// A habit the user is tracking, e.g. "Meditate" or "Read 20 minutes".
@immutable
class Habit {
  const Habit({required this.id, required this.name, required this.createdAt});

  final int id;
  final String name;
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Habit &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, name, createdAt);
}
