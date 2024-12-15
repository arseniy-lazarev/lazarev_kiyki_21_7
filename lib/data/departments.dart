import 'package:flutter/material.dart';
import '../models/department.dart';

const DEPARTMENTS = [
  DepartmentModel(
    id: 'finance',
    name: 'Finance',
    color: Colors.green,
    icon: Icons.account_balance,
  ),
  DepartmentModel(
    id: 'law',
    name: 'Law',
    color: Colors.blue,
    icon: Icons.gavel,
  ),
  DepartmentModel(
    id: 'it',
    name: 'IT',
    color: Colors.orange,
    icon: Icons.computer,
  ),
  DepartmentModel(
    id: 'medical',
    name: 'Medical',
    color: Colors.red,
    icon: Icons.local_hospital,
  ),
];
