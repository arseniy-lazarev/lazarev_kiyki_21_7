import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../providers/students_provider.dart';
import '../widgets/student_item.dart';
import '../widgets/new_student.dart';
import '../utils/snackbar_utils.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);

    void addOrEditStudent({Student? student, int? index}) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return NewStudent(
            student: student,
            onSave: (newStudent) {
              if (student == null) {
                ref.read(studentsProvider.notifier).addStudent(newStudent);
              } else if (index != null) {
                ref.read(studentsProvider.notifier).editStudent(newStudent, index);
              }
            },
          );
        },
      );
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Dismissible(
            key: ValueKey(student),
            background: Container(color: Colors.red),
            onDismissed: (_) {
              ref.read(studentsProvider.notifier).removeStudent(student);
              showUndoSnackbar(context, ref);
            },
            child: StudentItem(
              student: student,
              onTap: () => addOrEditStudent(student: student, index: index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addOrEditStudent(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
