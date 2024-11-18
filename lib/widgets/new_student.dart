import 'package:flutter/material.dart';
import '../models/student.dart';

class NewStudent extends StatefulWidget {
  final Student? student;
  final Function(Student) onSave;

  const NewStudent({Key? key, this.student, required this.onSave}) : super(key: key);

  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  Department _selectedDepartment = Department.it;
  Gender _selectedGender = Gender.male;
  int _grade = 1;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _selectedDepartment = widget.student!.department;
      _selectedGender = widget.student!.gender;
      _grade = widget.student!.grade;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    final newStudent = Student(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      department: _selectedDepartment,
      grade: _grade,
      gender: _selectedGender,
    );
    widget.onSave(newStudent);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              DropdownButton<Department>(
                value: _selectedDepartment,
                items: Department.values.map((dept) {
                  return DropdownMenuItem(value: dept, child: Text(dept.toString().split('.').last));
                }).toList(),
                onChanged: (dept) => setState(() => _selectedDepartment = dept!),
              ),
              DropdownButton<Gender>(
                value: _selectedGender,
                items: Gender.values.map((gender) {
                  return DropdownMenuItem(value: gender, child: Text(gender.toString().split('.').last));
                }).toList(),
                onChanged: (gender) => setState(() => _selectedGender = gender!),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Grade'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _grade = int.parse(value),
              ),
              ElevatedButton(
                onPressed: _saveStudent,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
