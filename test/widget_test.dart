import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/app/app.dart';

void main() {
  testWidgets('app boots and shows the habit list placeholder', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: HabitTrackerApp()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Habits'), findsOneWidget);
  });
}
