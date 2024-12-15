import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';

void showUndoSnackbar(BuildContext context, WidgetRef ref) {
  final notifier = ref.read(studentsProvider.notifier);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text('Student removed'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          notifier.undoRemove();
        },
      ),
    ),
  );
}