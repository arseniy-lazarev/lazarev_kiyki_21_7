import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/department.dart';

final departmentsProvider = Provider<List<DepartmentModel>>((ref) {
  return [
    const DepartmentModel(
      id: 'finance',
      name: 'Finance',
      color: Colors.green,
      icon: Icons.account_balance,
    ),
    const DepartmentModel(
      id: 'law',
      name: 'Law',
      color: Colors.blue,
      icon: Icons.gavel,
    ),
    const DepartmentModel(
      id: 'it',
      name: 'IT',
      color: Colors.orange,
      icon: Icons.computer,
    ),
    const DepartmentModel(
      id: 'medical',
      name: 'Medical',
      color: Colors.red,
      icon: Icons.local_hospital,
    ),
  ];
});
