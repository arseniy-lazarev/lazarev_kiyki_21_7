import 'package:flutter/material.dart';
import '../models/department.dart';

class DepartmentItem extends StatelessWidget {
  final DepartmentModel department;
  final int studentCount;

  const DepartmentItem({
    super.key,
    required this.department,
    required this.studentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Icon(
                department.icon,
                size: 40,
                color: department.color,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                department.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                '$studentCount Students',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}