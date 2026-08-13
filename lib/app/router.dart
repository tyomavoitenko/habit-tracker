import 'package:go_router/go_router.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit.dart';
import 'package:habit_tracker/features/habits/presentation/screens/habit_form_screen.dart';
import 'package:habit_tracker/features/habits/presentation/screens/habit_list_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HabitListScreen()),
      GoRoute(
        path: '/habits/new',
        builder: (context, state) => const HabitFormScreen(),
      ),
      GoRoute(
        path: '/habits/:id/edit',
        builder: (context, state) =>
            HabitFormScreen(habitToEdit: state.extra! as Habit),
      ),
    ],
  );
}
