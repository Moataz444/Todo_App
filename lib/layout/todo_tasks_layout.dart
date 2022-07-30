import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/database_controller.dart';
import 'package:todo_app/shared/components/components.dart';
import '../controllers/Theme_Controller.dart';
import '../shared/components/constants.dart';

class TodoTasks extends StatefulWidget {
  const TodoTasks({Key? key}) : super(key: key);

  @override
  State<TodoTasks> createState() => _TodoTasksState();
}

class _TodoTasksState extends State<TodoTasks> {
  int indx = 0;
  var dbController = Get.put(DatabaseController());

  @override
  void initState() {
    super.initState();
    dbController.createDatabase();
  }

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
                actions: [
                  if (title[indx] != 'Settings')
                    addTaskButton(context: context),
                ],
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
