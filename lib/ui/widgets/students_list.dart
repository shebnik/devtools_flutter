import 'package:devtools_flutter/main.dart';
import 'package:devtools_flutter/ui/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'package:devtools_flutter/models/student.dart';
import 'package:devtools_flutter/ui/widgets/student_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentsList extends ConsumerWidget {
  const StudentsList({
    Key? key,
    this.activistChanged,
  }) : super(key: key);

  final void Function(bool?, Student)? activistChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme.headline6;
    final students = ref.watch(studentsProvider);

    final studentsController = ref.watch(studentsProvider.notifier);
    final activistsController = ref.watch(activistsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Список студентов',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Студент',
                  style: textStyle,
                ),
                Text(
                  'Активист',
                  style: textStyle,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                ValueNotifier<Student> student = ValueNotifier(students[index]);
                return ValueListenableBuilder<Student>(
                  valueListenable: student,
                  builder: (_, value, __) => StudentTile(
                    student: value,
                    activistChanged: (Student activist) async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) => AppBottomSheet(
                          student: activist,
                          updateStudent: () {
                            studentsController.updateStudent(activist);
                            activist.isActivist
                                ? activistsController.remove(activist)
                                : activistsController.add(
                                    activist.copyWith(
                                        isActivist: !activist.isActivist),
                                  );
                            student.value =
                                activist.copyWith(isActivist: !value.isActivist);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
