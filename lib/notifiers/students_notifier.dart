import 'package:devtools_flutter/models/student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier(List<Student> students) : super([]) {
    state = students;
  }

  List<Student> getActivists() {
    return state.where((element) => element.isActivist).toList();
  }

  void updateStudent(Student student) {
    var list = state;
    list[student.id - 1] = student.copyWith(isActivist: !student.isActivist);
    state = list;
  }
}

class ActivistsNotifier extends StateNotifier<List<Student>> {
  ActivistsNotifier(List<Student> activists) : super([]) {
    state = activists;
  }

  void add(Student student) {
    state = [...state, student];
  }

  void remove(Student student) {
    state = state.where((element) => element.id != student.id).toList();
  }
}
