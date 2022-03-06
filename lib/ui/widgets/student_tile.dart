import 'package:flutter/material.dart';

import 'package:devtools_flutter/models/student.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    Key? key,
    required this.student,
    this.activistChanged,
  }) : super(key: key);

  final Student student;
  final void Function(Student)? activistChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: ClipOval(
          child: student.photo.startsWith('assets')
              ? Image.asset(student.photo)
              : Image.network(student.photo),
        ),
      ),
      title: Text(student.name),
      subtitle: Text('Средний балл: ${student.gpa.toString()}'),
      trailing: activistChanged == null
          ? null
          : Checkbox(
              value: student.isActivist,
              onChanged: (value) => activistChanged!(student),
            ),
    );
  }
}
