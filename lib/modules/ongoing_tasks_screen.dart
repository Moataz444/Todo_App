import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/database_controller.dart';
import 'package:todo_app/shared/components/components.dart';

class OngoingTasksScreen extends StatefulWidget {
  const OngoingTasksScreen({Key? key}) : super(key: key);

  @override
  State<OngoingTasksScreen> createState() => _OngoingTasksScreenState();
}

class _OngoingTasksScreenState extends State<OngoingTasksScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheet = false;
  final dbController = Get.put(DatabaseController());
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<DatabaseController>(
          init: DatabaseController(),
          builder: (dbController) => Container(
            // width: MediaQuery.of(context).size.width,
            child: taskBuilder(tasks: ongoingTasks),
          ),
        ),
        floatingActionButton: Builder(
            builder: (context) => Container(
                  // padding: const EdgeInsets.only(bottom: 27),
                  child: FloatingActionButton(
                      onPressed: () {
                        // print(tasksDB['OngoingTasks']);
                        dbController.insertDatabase(
                            date: 'mon',
                            title: ' vdc ${x++}',
                            time: '555',
                            status: 'archived',
                            details: 'ddcds s  ');
                        dbController.getDataFromDB(dbController.db);
                        // setState(() {});
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('task added  successfully'),
                        ));
                        // if (!isBottomSheet) {
                        //   isBottomSheet = true;
                        //   showBottomSheet(
                        //       elevation: 25,
                        //       builder: (context) => Container(
                        //             height: 200,
                        //             width: double.infinity,
                        //           ),
                        //       context: context);
                        // } else {
                        //   isBottomSheet = false;
                        //   Get.back();
                        // }
                      },
                      child: const Icon(Icons.add)),
                )));
  }
}
