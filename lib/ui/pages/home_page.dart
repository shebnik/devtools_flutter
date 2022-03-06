import 'package:devtools_flutter/ui/widgets/activists_list.dart';
import 'package:devtools_flutter/ui/widgets/students_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _StudentsWidgetState createState() => _StudentsWidgetState();
}

class _StudentsWidgetState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ValueNotifier<int> currentTabIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        currentTabIndex.value = _tabController.index;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          StudentsList(),
          ActivistsList(),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentTabIndex,
        builder: (context, value, __) => BottomNavigationBar(
          currentIndex: value,
          onTap: (index) {
            _tabController.index = index;
            currentTabIndex.value = index;
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
      ),
    );
  }
}
