import 'package:flutter/material.dart';
import '../models/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';
import '../models/department.dart';
import '../data/departments.dart';
import '../providers/departments_provider.dart';

class NewStudent extends ConsumerStatefulWidget {
  const NewStudent({
    super.key,
    this.studentIndex
  });

  final int? studentIndex;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewStudentState();
}

class _NewStudentState extends ConsumerState<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DepartmentModel _selectedDepartment = DEPARTMENTS[0];
  Gender _selectedGender = Gender.male;
  int _grade = 1;

  @override
  void initState() {
    super.initState();
    if (widget.studentIndex != null) {
      final student = ref.read(studentsProvider).students[widget.studentIndex!];
      _firstNameController.text = student.firstName;
      _lastNameController.text = student.lastName;
      _grade = student.grade;
      _selectedGender = student.gender;
      _selectedDepartment = student.department;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveStudent() async {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (widget.studentIndex != null) {
      await ref.read(studentsProvider.notifier).editStudent(
            widget.studentIndex!,
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedDepartment,
            _selectedGender,
            _grade,
          );
    } else {
      await ref.read(studentsProvider.notifier).addStudent(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _selectedDepartment,
            _selectedGender,
            _grade,
          );
    }

    if (!context.mounted) return;
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    final departments = ref.watch(departmentsProvider);

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              const SizedBox(height: 16),
              DropdownButton<DepartmentModel>(
                value: _selectedDepartment,
                isExpanded: true,
                items: departments.map((dept) {
                  return DropdownMenuItem(
                    value: dept,
                    child: Row(
                      children: [
                        Icon(dept.icon, color: dept.color),
                        const SizedBox(width: 8),
                        Text(dept.name.split('.').last),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (dept) => setState(() => _selectedDepartment = dept!),
              ),
              const SizedBox(height: 16),
              DropdownButton<Gender>(
                value: _selectedGender,
                isExpanded: true,
                items: Gender.values.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (gender) => setState(() => _selectedGender = gender!),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(labelText: 'Grade'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final parsedGrade = int.tryParse(value);
                  if (parsedGrade != null) {
                    _grade = parsedGrade;
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveStudent,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
