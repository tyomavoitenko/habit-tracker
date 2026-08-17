// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(habits)
const habitsProvider = HabitsProvider._();

final class HabitsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Habit>>,
          List<Habit>,
          Stream<List<Habit>>
        >
    with $FutureModifier<List<Habit>>, $StreamProvider<List<Habit>> {
  const HabitsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitsHash();

  @$internal
  @override
  $StreamProviderElement<List<Habit>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Habit>> create(Ref ref) {
    return habits(ref);
  }
}

String _$habitsHash() => r'a2ad3dd1be714cf569a9861123302469da0e9689';

@ProviderFor(habitCheckIns)
const habitCheckInsProvider = HabitCheckInsFamily._();

final class HabitCheckInsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CheckIn>>,
          List<CheckIn>,
          Stream<List<CheckIn>>
        >
    with $FutureModifier<List<CheckIn>>, $StreamProvider<List<CheckIn>> {
  const HabitCheckInsProvider._({
    required HabitCheckInsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'habitCheckInsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$habitCheckInsHash();

  @override
  String toString() {
    return r'habitCheckInsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<CheckIn>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CheckIn>> create(Ref ref) {
    final argument = this.argument as int;
    return habitCheckIns(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HabitCheckInsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$habitCheckInsHash() => r'4da79b31bf6235fff201805189e69bdc0ce92a9b';

final class HabitCheckInsFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<CheckIn>>, int> {
  const HabitCheckInsFamily._()
    : super(
        retry: null,
        name: r'habitCheckInsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HabitCheckInsProvider call(int habitId) =>
      HabitCheckInsProvider._(argument: habitId, from: this);

  @override
  String toString() => r'habitCheckInsProvider';
}

@ProviderFor(isHabitCheckedInToday)
const isHabitCheckedInTodayProvider = IsHabitCheckedInTodayFamily._();

final class IsHabitCheckedInTodayProvider
    extends
        $FunctionalProvider<
          AsyncValue<bool>,
          AsyncValue<bool>,
          AsyncValue<bool>
        >
    with $Provider<AsyncValue<bool>> {
  const IsHabitCheckedInTodayProvider._({
    required IsHabitCheckedInTodayFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'isHabitCheckedInTodayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isHabitCheckedInTodayHash();

  @override
  String toString() {
    return r'isHabitCheckedInTodayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AsyncValue<bool>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<bool> create(Ref ref) {
    final argument = this.argument as int;
    return isHabitCheckedInToday(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<bool>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsHabitCheckedInTodayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isHabitCheckedInTodayHash() =>
    r'b8981ae81e871061e9d41519f8f03b8e3b623b80';

final class IsHabitCheckedInTodayFamily extends $Family
    with $FunctionalFamilyOverride<AsyncValue<bool>, int> {
  const IsHabitCheckedInTodayFamily._()
    : super(
        retry: null,
        name: r'isHabitCheckedInTodayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsHabitCheckedInTodayProvider call(int habitId) =>
      IsHabitCheckedInTodayProvider._(argument: habitId, from: this);

  @override
  String toString() => r'isHabitCheckedInTodayProvider';
}

@ProviderFor(currentStreak)
const currentStreakProvider = CurrentStreakFamily._();

final class CurrentStreakProvider
    extends
        $FunctionalProvider<AsyncValue<int>, AsyncValue<int>, AsyncValue<int>>
    with $Provider<AsyncValue<int>> {
  const CurrentStreakProvider._({
    required CurrentStreakFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'currentStreakProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentStreakHash();

  @override
  String toString() {
    return r'currentStreakProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AsyncValue<int>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AsyncValue<int> create(Ref ref) {
    final argument = this.argument as int;
    return currentStreak(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<int>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentStreakProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentStreakHash() => r'2539bfcad4299938a3970f47188a9c3f1dff6c44';

final class CurrentStreakFamily extends $Family
    with $FunctionalFamilyOverride<AsyncValue<int>, int> {
  const CurrentStreakFamily._()
    : super(
        retry: null,
        name: r'currentStreakProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrentStreakProvider call(int habitId) =>
      CurrentStreakProvider._(argument: habitId, from: this);

  @override
  String toString() => r'currentStreakProvider';
}
