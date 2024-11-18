import 'package:flutter/material.dart';
class Student {
  final String firstName;
  final String lastName;
  final Department department;
  final int grade;
  final Gender gender;

  const Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });
}

enum Department { finance, law, it, medical }
enum Gender { male, female }

final Map<Department, IconData> departmentIcons = {
  Department.finance: Icons.account_balance,
  Department.law: Icons.gavel,
  Department.it: Icons.computer,
  Department.medical: Icons.local_hospital,
};
