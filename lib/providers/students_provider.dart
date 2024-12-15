import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier() : super([]);

  Student? _recentlyDeletedStudent;

  void addStudent(Student student) {
    state = [...state, student];
  }

  void editStudent(Student updatedStudent, int index) {
    final newState = [...state];
    newState[index] = updatedStudent;
    state = newState;
  }

  void removeStudent(Student student) {
    _recentlyDeletedStudent = student;
    state = state.where((s) => s != student).toList();
  }

  void undoRemove() {
    if (_recentlyDeletedStudent != null) {
      state = [...state, _recentlyDeletedStudent!];
      _recentlyDeletedStudent = null;
    }
  }

  bool get canUndo => _recentlyDeletedStudent != null;
}

final studentsProvider = StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
  return StudentsNotifier();
});