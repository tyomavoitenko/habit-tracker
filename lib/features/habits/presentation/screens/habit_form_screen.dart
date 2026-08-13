import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/features/habits/domain/entities/habit.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habit_form_controller.dart';

class HabitFormScreen extends ConsumerStatefulWidget {
  const HabitFormScreen({this.habitToEdit, super.key});

  final Habit? habitToEdit;

  @override
  ConsumerState<HabitFormScreen> createState() => _HabitFormScreenState();
}

class _HabitFormScreenState extends ConsumerState<HabitFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(
    text: widget.habitToEdit?.name,
  );

  bool get _isEditing => widget.habitToEdit != null;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref
        .read(habitFormControllerProvider.notifier)
        .submit(
          habitId: widget.habitToEdit?.id,
          name: _nameController.text.trim(),
        );
  }

  Future<void> _delete() async {
    final habitId = widget.habitToEdit?.id;
    if (habitId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete habit?'),
        content: const Text(
          'This will also delete all of its check-in history. '
          'This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      if (!mounted) return;
      await ref.read(habitFormControllerProvider.notifier).delete(habitId);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(habitFormControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong: ${next.error}')),
        );
      } else if (previous?.isLoading ?? false) {
        if (next.hasValue) context.pop();
      }
    });

    final isSubmitting = ref.watch(
      habitFormControllerProvider.select((s) => s.isLoading),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit habit' : 'New habit'),
        actions: [
          if (_isEditing)
            IconButton(
              onPressed: isSubmitting ? null : _delete,
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                autofocus: !_isEditing,
                maxLength: 100,
                decoration: const InputDecoration(labelText: 'Habit name'),
                validator: (value) {
                  final trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) return 'Enter a habit name';
                  if (trimmed.length > 100) {
                    return 'Keep it under 100 characters';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: isSubmitting ? null : _submit,
                child: Text(_isEditing ? 'Save' : 'Add habit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
