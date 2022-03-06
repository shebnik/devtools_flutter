import 'package:devtools_flutter/models/student.dart';
import 'package:devtools_flutter/notifiers/students_notifier.dart';
import 'package:devtools_flutter/services/student_service.dart';
import 'package:devtools_flutter/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Feature Toggle
// ignore: constant_identifier_names
const bool NETWORK_ENABLED = false;

late final StateNotifierProvider<StudentsNotifier, List<Student>>
    studentsProvider;
late final StateNotifierProvider<ActivistsNotifier, List<Student>>
    activistsProvider;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: FutureBuilder(
            future: NETWORK_ENABLED
                ? StudentService.fetchStudents()
                : StudentService.loadStudents(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final List<Student> students = snapshot.data;
                studentsProvider =
                    StateNotifierProvider<StudentsNotifier, List<Student>>(
                  (_) => StudentsNotifier(students),
                );
                activistsProvider =
                    StateNotifierProvider<ActivistsNotifier, List<Student>>(
                  (_) => ActivistsNotifier(
                      students.where((element) => element.isActivist).toList()),
                );
                return const HomePage();
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
