import 'package:flutter/material.dart';

import '../modules/archived_tasks_screen.dart';
import '../modules/done_tasks_screen.dart';
import '../modules/ongoing_tasks_screen.dart';
import '../modules/settings_screen.dart';
import '../shared/styles/colors.dart';

class TodoTasks extends StatefulWidget {
  TodoTasks({Key? key}) : super(key: key);

  @override
  State<TodoTasks> createState() => _TodoTasksState();
}

class _TodoTasksState extends State<TodoTasks> {
  final List<Widget> screens = [
    const OngoingTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
    const SettingsScreen(),
  ];

  final List<String> title = [
    'Ongoing Tasks',
    'Done Tasks',
    'Archived Tasks',
    'Settings',
  ];

  int indx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clr,
        centerTitle: true,
        title: Text(title[indx]),
      ),
      body: screens[indx],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: clr,
        type: BottomNavigationBarType.fixed,
        currentIndex: indx,
        onTap: (index) {
          setState(() {
            indx = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.backup_table_sharp),
            label: 'Ongoing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Archived',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
