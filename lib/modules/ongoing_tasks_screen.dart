import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/database_controller.dart';
import 'package:todo_app/shared/components/components.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  // var scaffoldKey = GlobalKey<ScaffoldState>();
  // bool isBottomSheet = false;
  final dbController = Get.put(DatabaseController());

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
      // floatingActionButton: Builder(
      //     builder: (context) => FloatingActionButton(
      //         onPressed: () {
      //           showInsertDialog(context);

      // print(tasksDB['OngoingTasks']);

      // dbController.insertDatabase(
      //     date: 'mon',
      //     title: ' vdc ${x++}',
      //     time: '555',
      //     status: 'new',
      //     details: 'ddcds s  ');

      // setState(() {});

      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('task added  successfully'),
      // ));

      //if (!isBottomSheet) {
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
      // },
      // child: const Icon(Icons.add),),),
    );
  }
}
