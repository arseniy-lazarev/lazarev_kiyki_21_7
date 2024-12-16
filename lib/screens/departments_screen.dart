import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/departments_provider.dart';
import '../providers/students_provider.dart';
import '../widgets/department_item.dart';

class DepartmentsScreen extends ConsumerWidget {
  const DepartmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departments = ref.watch(departmentsProvider);
    final students = ref.watch(studentsProvider);

    return GridView(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      children: departments.map((department) {
        final studentCount = students
            .where((s) => s.department.name.toLowerCase() == department.id)
            .length;
        return DepartmentItem(
          department: department,
          studentCount: studentCount,
        );
      }).toList(),
    );
  }
}