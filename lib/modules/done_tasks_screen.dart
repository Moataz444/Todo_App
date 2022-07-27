import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controllers/database_controller.dart';
import '../shared/components/components.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(
      init: DatabaseController(),
      builder: (dbController) => Container(
        // width: MediaQuery.of(context).size.width,
        child: taskBuilder(tasks: doneTasks),
      ),
    );
  }
}
