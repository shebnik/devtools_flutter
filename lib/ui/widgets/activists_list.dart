import 'package:devtools_flutter/main.dart';
import 'package:devtools_flutter/ui/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'package:devtools_flutter/models/student.dart';
import 'package:devtools_flutter/ui/widgets/student_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivistsList extends ConsumerWidget {
  const ActivistsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activists = ref.watch(activistsProvider);

    final studentsController = ref.watch(studentsProvider.notifier);
    final activistsController = ref.watch(activistsProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Список активистов',
        ),
      ),
      body: ListView.builder(
        itemCount: activists.length,
        itemBuilder: (context, index) {
          final student = activists[index];
          return StudentTile(
            key: UniqueKey(),
            student: student,
            activistChanged: (Student student) async {
              await showModalBottomSheet(
                context: context,
                builder: (context) => AppBottomSheet(
                  student: student,
                  updateStudent: () {
                    studentsController.updateStudent(student);
                    student.isActivist
                        ? activistsController.remove(student)
                        : activistsController.add(
                            student.copyWith(isActivist: !student.isActivist),
                          );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
