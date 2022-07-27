import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/database_controller.dart';
import '../shared/components/components.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatabaseController>(
      init: DatabaseController(),
      builder: (dbController) => Container(
        // width: MediaQuery.of(context).size.width,
        child: taskBuilder(tasks: archivedTasks),
      ),
    );
  }
}
