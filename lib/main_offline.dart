import 'package:devtools_flutter/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'services/offline_student_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: OfflineStudentService.fetchStudents(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return HomePage(students: snapshot.data);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
