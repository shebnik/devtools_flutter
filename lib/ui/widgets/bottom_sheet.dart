import 'package:flutter/material.dart';

import 'package:devtools_flutter/models/student.dart';
import 'package:devtools_flutter/ui/widgets/student_tile.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    Key? key,
    required this.student,
    required this.updateStudent,
  }) : super(key: key);

  final Student student;
  final void Function() updateStudent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Center(
            child: Text(
              !student.isActivist ? 'Добавить активиста' : 'Удалить активиста',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: 16),
          StudentTile(student: student),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text("Подтвердить"),
            onPressed: () {
              updateStudent();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
