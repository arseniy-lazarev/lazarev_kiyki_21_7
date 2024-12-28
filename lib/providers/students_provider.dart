import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';

class StudentsState {
  final List<Student> students;
  final bool isLoading;
  final String? errorMessage;

  StudentsState({
    required this.students,
    required this.isLoading,
    this.errorMessage,
  });

  StudentsState copyWith({
    List<Student>? students,
    bool? isLoading,
    String? errorMessage,
  }) {
    return StudentsState(
      students: students ?? this.students,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class StudentsNotifier extends StateNotifier<StudentsState> {
  StudentsNotifier() : super(StudentsState(students: [], isLoading: false));

  Student? reserve;
  int? reserveId;

  Future<void> loadList() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final students = await Student.remoteGetList();
      state = state.copyWith(students: students, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error: $e',
      );
    }
  }

  Future<void> addStudent(
    String firstName,
    String lastName,
    department,
    gender,
    int grade,
  ) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final student = await Student.remoteCreate(
          firstName, lastName, department, gender, grade);
      state = state.copyWith(
        students: [...state.students, student],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error: $e',
      );
    }
  }

  Future<void> editStudent(
    int index,
    String firstName,
    String lastName,
    department,
    gender,
    int grade,
  ) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final updatedStudent = await Student.remoteUpdate(
        state.students[index].id,
        firstName,
        lastName,
        department,
        gender,
        grade,
      );
      final updatedList = [...state.students];
      updatedList[index] = updatedStudent;
      state = state.copyWith(students: updatedList, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error: $e',
      );
    }
  }

  void removeStudent(int index) {
    reserve = state.students[index];
    reserveId = index;
    final updatedList = [...state.students];
    updatedList.removeAt(index);
    state = state.copyWith(students: updatedList);
  }

  void undoRemove() {
    if (reserve != null && reserveId != null) {
      final updatedList = [...state.students];
      updatedList.insert(reserveId!, reserve!);
      state = state.copyWith(students: updatedList);
    }
  }

  Future<void> remove() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      if (reserve != null) {
        await Student.remoteDelete(reserve!.id);
        reserve = null;
        reserveId = null;
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error: $e',
      );
    }
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, StudentsState>((ref) {
  final notifier = StudentsNotifier();
  notifier.loadList();
  return notifier;
});
