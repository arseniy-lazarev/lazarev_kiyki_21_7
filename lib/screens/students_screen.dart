import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';
import '../widgets/student_item.dart';
import '../widgets/new_student.dart';
import '../utils/snackbar_utils.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final students = ref.watch(studentsProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (students.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              students.errorMessage!,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    void addOrEditStudent({int? index}) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return NewStudent(studentIndex: index);
        },
      );
    }

    if (students.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: students.students.length,
        itemBuilder: (context, index) {
          final student = students.students[index];
          return Dismissible(
            key: ValueKey(student),
            background: Container(color: Colors.red),
            onDismissed: (_) {
              ref.read(studentsProvider.notifier).removeStudent(index);
              showUndoSnackbar(context, ref);
            },
            child: StudentItem(
              student: student,
              onTap: () => addOrEditStudent(index: index),
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
