# Habit Tracker

[![CI](https://github.com/tyomavoitenko/habit-tracker/actions/workflows/ci.yml/badge.svg)](https://github.com/tyomavoitenko/habit-tracker/actions/workflows/ci.yml)

An offline-first habit tracker built with Flutter. Create habits, check them
off day by day, and see your current streak — no account, no backend, works
fully offline. Built as a portfolio project to demonstrate a clean,
feature-first architecture and the tooling around it (state management,
local persistence, testing, CI), not to be a feature-complete app.

## What it does

- Create, edit, and delete habits
- Check a habit in for today, or undo it
- See the current streak and the last 14 days of history for each habit
- Everything persists locally and works with no network connection

## Architecture

The app follows Clean Architecture with a feature-first folder layout. Each
feature owns its own domain/data/presentation slices; cross-cutting
infrastructure (the database, theming, routing) lives in `core/` and `app/`.

```
lib/
  app/                        # App shell: MaterialApp, go_router config
  core/
    database/                 # AppDatabase (Drift) + its Riverpod provider
    theme/                    # App-wide ThemeData
  features/
    habits/
      domain/
        entities/             # Habit, CheckIn — plain, framework-free
        repositories/         # HabitRepository (abstract)
        streak_calculator.dart
      data/
        tables/                # Drift table definitions
        repositories/         # DriftHabitRepository (implements HabitRepository)
      presentation/
        providers/            # Riverpod providers (riverpod_generator)
        screens/
        widgets/
```

The dependency rule flows inward: `presentation` depends on `domain`
abstractions, `data` implements them, and `domain` depends on nothing
Flutter- or Drift-specific. `streak_calculator.dart`, for example, is a pure
function with no framework imports — it's exercised directly by unit tests
with no mocking.

### A few decisions worth calling out

- **Habits and check-ins share one repository.** A `CheckIn` has no
  lifecycle apart from its habit, so `HabitRepository` owns both rather than
  being split into two repositories that would always be used together.
- **Cascade delete needed an explicit `PRAGMA`.** SQLite has foreign key
  enforcement off per connection by default, so the `onDelete: cascade` on
  `CheckIns.habitId` was silently a no-op until `AppDatabase` turned it on
  via `MigrationStrategy.beforeOpen` — caught by a repository test, not by
  hand-testing the UI.
- **Streak logic lives in the domain layer as a pure function**
  (`calculateCurrentStreak`), not inline in a provider or widget, so the
  business rule ("today not yet checked in doesn't break the streak") is
  testable in isolation and has nothing to do with Riverpod or Flutter.
- **CI runs on `macos-latest`, not the more common `ubuntu-latest`.** The
  test suite includes a golden (pixel-comparison) test, and Flutter's golden
  files are only reliable when generated and compared on the same OS
  family. The committed goldens were generated on macOS, so CI matches that.

## Tech stack

| Concern | Choice |
| --- | --- |
| State management | [Riverpod](https://riverpod.dev) with `riverpod_generator` (`@riverpod` code generation, not the legacy `Provider` API) |
| Local persistence | [Drift](https://drift.simonbinder.eu) (SQLite), wired via `drift_flutter` |
| Routing | [go_router](https://pub.dev/packages/go_router) |
| Architecture | Clean Architecture, feature-first folders |
| Lints | [very_good_analysis](https://pub.dev/packages/very_good_analysis) |
| Flutter SDK | Pinned via [FVM](https://fvm.app) — see `.fvmrc` |

## Getting started

This project pins its Flutter SDK version with FVM. Install FVM first if you
don't have it:

```bash
dart pub global activate fvm
```

Then, from the project root:

```bash
fvm install          # installs the Flutter version pinned in .fvmrc
fvm flutter pub get
fvm dart run build_runner build --delete-conflicting-outputs --force-jit
fvm flutter run
```

`--force-jit` is required for code generation on recent Dart SDKs: some
transitive dependencies carry Dart's native-assets "build hooks," which the
default AOT compilation path used by `build_runner` refuses to touch.

## Testing

```bash
fvm flutter analyze
fvm flutter test
```

The suite covers:

- **Domain unit tests** — `calculateCurrentStreak`, exercised directly with
  no mocking (`test/features/habits/domain/`)
- **Repository tests** — `DriftHabitRepository` against an in-memory Drift
  database (`test/features/habits/data/`)
- **Widget tests** — key screen states, overriding `appDatabaseProvider`
  with an in-memory database (`test/features/habits/presentation/`)
- **A golden test** — `HabitListTile` in both check-in states

To regenerate golden files after an intentional UI change:

```bash
fvm flutter test --update-goldens
```

## CI

Every push to `main` and every pull request runs `flutter analyze` and
`flutter test` via GitHub Actions (see `.github/workflows/ci.yml`). All
changes to this repo go through a pull request rather than being pushed
directly to `main`.
