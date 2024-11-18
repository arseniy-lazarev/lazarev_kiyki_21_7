import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;

  const StudentItem({Key? key, required this.student, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: student.gender == Gender.male ? Colors.blue[50] : Colors.pink[50],
        child: ListTile(
          title: Text(
            '${student.firstName} ${student.lastName} - Grade: ${student.grade}',
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
          leading: Icon(departmentIcons[student.department], color: Colors.grey),
        ),
      ),
    );
  }
}
