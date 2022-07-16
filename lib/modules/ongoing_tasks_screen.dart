import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/database_controller.dart';
import 'package:todo_app/shared/styles/colors.dart';

class OngoingTasksScreen extends StatefulWidget {
  OngoingTasksScreen({Key? key}) : super(key: key);

  @override
  State<OngoingTasksScreen> createState() => _OngoingTasksScreenState();
}

class _OngoingTasksScreenState extends State<OngoingTasksScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: const [
              // ReorderableListView(children: children, onReorder: onReorder),
              Text('Ongoing Tasks Screen'),
            ],
          ),
        ),
        floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
                onPressed: () {
                  insertDatabase(date: 'mon', name: 'nam', time: '555');
                  if (!isBottomSheet) {
                    isBottomSheet = true;
                    showBottomSheet(
                        elevation: 25,
                        builder: (context) => Container(
                              height: 200,
                              width: double.infinity,
                            ),
                        context: context);
                  } else {
                    isBottomSheet = false;
                    Get.back();
                  }
                },
                child: const Icon(Icons.add))));
  }
}
