// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HabitFormController)
const habitFormControllerProvider = HabitFormControllerProvider._();

final class HabitFormControllerProvider
    extends $AsyncNotifierProvider<HabitFormController, void> {
  const HabitFormControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'habitFormControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$habitFormControllerHash();

  @$internal
  @override
  HabitFormController create() => HabitFormController();
}

String _$habitFormControllerHash() =>
    r'b289f8b0455fb7f029f1aaedd05a63bbefcb9c53';

abstract class _$HabitFormController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
