import 'package:devtools_flutter/models/student.dart';
import 'package:devtools_flutter/ui/widgets/student_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.students,
  }) : super(key: key);

  final List<Student> students;

  @override
  _StudentsWidgetState createState() => _StudentsWidgetState();
}

class _StudentsWidgetState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late List<Student> students;
  late List<Student> activists;
  late TabController _tabController;
  int currentTabIndex = 0;
  final List<String> appBarTitle = [
    'Список студентов',
    'Список активистов',
  ];

  @override
  void initState() {
    super.initState();
    students = widget.students;
    activists = widget.students.where((student) => student.isActivist).toList();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        currentTabIndex = _tabController.index;
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarTitle[currentTabIndex],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          studentsList(),
          activistsList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (index) {
          _tabController.index = index;
          currentTabIndex = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Студенты",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Активисты",
          ),
        ],
      ),
    );
  }

  studentsList() {
    final textStyle = Theme.of(context).textTheme.headline6;
    return Column(
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
              final student = students[index];
              return StudentTile(
                student: student,
                activistChanged: _activistChanged,
              );
            },
          ),
        ),
      ],
    );
  }

  activistsList() {
    return ListView.builder(
      itemCount: activists.length,
      itemBuilder: (context, index) {
        final student = activists[index];
        return StudentTile(
          student: student,
          activistChanged: _activistChanged,
        );
      },
    );
  }

  _activistChanged(bool? value, Student student) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Center(
                child: Text(
                  !student.isActivist
                      ? 'Добавить активиста'
                      : 'Удалить активиста',
                      style: Theme.of(context).textTheme.headline6,
                ),
              ),
              const SizedBox(height: 16),
              StudentTile(student: student),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text("Подтвердить"),
                onPressed: () {
                  final updatedStudent =
                      student.copyWith(isActivist: !student.isActivist);
                  student.isActivist
                      ? activists.remove(student)
                      : activists.add(updatedStudent);
                  students[student.id - 1] = updatedStudent;
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
