import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/Theme_Controller.dart';
import '../modules/archived_tasks_screen.dart';
import '../modules/done_tasks_screen.dart';
import '../modules/ongoing_tasks_screen.dart';
import '../modules/settings_screen.dart';

class TodoTasks extends StatefulWidget {
  const TodoTasks({Key? key}) : super(key: key);

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
  // final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        // init: ThemeController(),
        builder: (themeController) => Scaffold(
              appBar: AppBar(
                // backgroundColor: clr,
                centerTitle: true,
                title: Text(title[indx]),
              ),
              body: screens[indx],
              bottomNavigationBar: BottomNavigationBar(
                // selectedItemColor: clr,
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
            ));
  }
}
