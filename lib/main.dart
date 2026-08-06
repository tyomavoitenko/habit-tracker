import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app/app.dart';

void main() {
  runApp(const ProviderScope(child: HabitTrackerApp()));
}
