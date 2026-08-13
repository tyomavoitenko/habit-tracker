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

@ProviderFor(isHabitCheckedInToday)
const isHabitCheckedInTodayProvider = IsHabitCheckedInTodayFamily._();

final class IsHabitCheckedInTodayProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
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
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as int;
    return isHabitCheckedInToday(ref, argument);
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
    r'cf57a7770d543020e48016ee51e913fb7dec5d86';

final class IsHabitCheckedInTodayFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, int> {
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
