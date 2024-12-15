import 'package:flutter/material.dart';

class DepartmentModel {
  final String id;
  final String name;
  final Color color;
  final IconData icon;

  const DepartmentModel({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
}
