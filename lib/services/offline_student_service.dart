import 'dart:convert';

import '../models/student.dart';
import 'package:flutter/services.dart' show rootBundle;

class OfflineStudentService {
  static Future<List<Student>> fetchStudents() async {
    final json = await rootBundle.loadString('assets/json/students.json');
    final data = jsonDecode(json) as List<dynamic>;
    return data.map((e) => Student.fromMap(e)).toList();
  }
}
