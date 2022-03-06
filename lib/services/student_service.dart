import 'dart:convert';
import 'package:http/http.dart';

import '../models/student.dart';

class StudentService {
  // ignore: constant_identifier_names
  static const STUDENTS_URL =
      'https://api.mockaroo.com/api/4d3ccd90?count=30&key=74e0feb0';

  static Future<List<Student>> fetchStudents() async {
    Client _client = Client();
    Response _response;
    try {
      _response = await _client.get(Uri.parse(STUDENTS_URL));
      final list = jsonDecode(_response.body) as List<dynamic>;
      return list.map((e) => Student.fromMap(e)).toList();
    } catch (e) {
      print('[StudentService] fetch students error - $e');
      return [];
    }
  }
}
