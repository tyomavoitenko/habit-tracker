import 'package:habit_tracker/features/habits/presentation/providers/habit_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'habit_form_controller.g.dart';

@riverpod
class HabitFormController extends _$HabitFormController {
  @override
  FutureOr<void> build() {}

  Future<void> submit({required int? habitId, required String name}) async {
    final repository = ref.read(habitRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      if (habitId == null) {
        await repository.createHabit(name);
      } else {
        await repository.updateHabit(habitId, name);
      }
    });
  }

  Future<void> delete(int habitId) async {
    final repository = ref.read(habitRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.deleteHabit(habitId));
  }
}
