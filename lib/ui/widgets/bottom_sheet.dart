import 'dart:async';

import 'package:flutter/material.dart';

import 'package:devtools_flutter/models/student.dart';
import 'package:devtools_flutter/ui/widgets/student_tile.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({
    Key? key,
    required this.student,
    required this.updateStudent,
  }) : super(key: key);

  final Student student;
  final void Function() updateStudent;

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  late StreamController streamController;
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    streamController = StreamController();
    streamSubscription = streamController.stream.listen((event) {});
    streamController.add("");
    streamController.add("");
    streamController.add("");
    streamController.add("");
    streamController.add("");
    streamController.add("");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Center(
            child: Text(
              !widget.student.isActivist
                  ? 'Добавить активиста'
                  : 'Удалить активиста',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: 16),
          StudentTile(student: widget.student),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text("Подтвердить"),
            onPressed: () {
              widget.updateStudent();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
