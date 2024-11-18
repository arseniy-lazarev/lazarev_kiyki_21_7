import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';
import 'new_student.dart';

class StudentsScreen extends StatefulWidget {
  @override
  _StudentsScreenState createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  List<Student> students = [
    const Student(
      firstName: 'Emma',
      lastName: 'Johnson',
      department: Department.finance,
      grade: 5,
      gender: Gender.female,
    ),
    const Student(
      firstName: 'Liam',
      lastName: 'Williams',
      department: Department.it,
      grade: 4,
      gender: Gender.male,
    ),
  ];

  void _showAddEditStudentDialog({Student? student}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewStudent(
          student: student,
          onSave: (newStudent) {
            setState(() {
              if (student == null) {
                students.add(newStudent);
              } else {
                final index = students.indexOf(student);
                students[index] = newStudent;
              }
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: () => _showAddEditStudentDialog(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Dismissible(
            key: ValueKey(student),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              final removedStudent = students[index];
              
              setState(() {
                students.removeAt(index);
              });
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${removedStudent.firstName} видалено'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        students.insert(index, removedStudent);
                      });
                    },
                  ),
                ),
              );
            },
            child: StudentItem(
              student: student,
              onTap: () => _showAddEditStudentDialog(student: student),
            ),
          );

        },
      ),
    );
  }
}
