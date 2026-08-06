import 'package:go_router/go_router.dart';
import 'package:habit_tracker/features/habits/presentation/screens/habit_list_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HabitListScreen(),
      ),
    ],
  );
}
