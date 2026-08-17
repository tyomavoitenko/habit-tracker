import 'package:flutter_test/flutter_test.dart';
import 'package:habit_tracker/features/habits/domain/streak_calculator.dart';

void main() {
  final today = DateTime(2026, 8, 17);
  DateTime daysAgo(int n) => today.subtract(Duration(days: n));

  group('calculateCurrentStreak', () {
    test('returns 0 for no check-ins', () {
      expect(calculateCurrentStreak([], today: today), 0);
    });

    test('counts a streak ending today', () {
      final dates = [today, daysAgo(1), daysAgo(2)];
      expect(calculateCurrentStreak(dates, today: today), 3);
    });

    test(
      'still counts a streak ending yesterday when today is not checked in',
      () {
        final dates = [daysAgo(1), daysAgo(2), daysAgo(3)];
        expect(calculateCurrentStreak(dates, today: today), 3);
      },
    );

    test('returns 0 once a full day has been skipped', () {
      // Neither today nor yesterday checked in — the streak is over, even
      // though there's older history.
      final dates = [daysAgo(2), daysAgo(3)];
      expect(calculateCurrentStreak(dates, today: today), 0);
    });

    test('stops counting at the first gap', () {
      final dates = [today, daysAgo(1), daysAgo(5), daysAgo(6)];
      expect(calculateCurrentStreak(dates, today: today), 2);
    });

    test('is unaffected by duplicate or out-of-order dates', () {
      final dates = [daysAgo(2), today, today, daysAgo(1), daysAgo(1)];
      expect(calculateCurrentStreak(dates, today: today), 3);
    });

    test('truncates time-of-day before comparing', () {
      final dates = [
        DateTime(2026, 8, 17, 23, 59),
        DateTime(2026, 8, 16, 0, 1),
      ];
      expect(calculateCurrentStreak(dates, today: today), 2);
    });
  });
}
