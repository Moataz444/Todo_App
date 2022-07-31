import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/shared/components/components.dart';
import '../controllers/database_controller.dart';
import '../shared/components/alert_dialog_componnets.dart';

Future<void> showEditDialog(context, Map task) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  statusController = task['status'];
  // final formKey = GlobalKey<FormState>();

  titleController.text = task['title'];
  dateController.text = task['date'];
  timeController.text = task['time'];
  detailsController.text = task['details'];
  return
      // Scaffold(
      // body: ,
      // )
      showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return GetBuilder<DatabaseController>(
        init: DatabaseController(),
        builder: (databaseController) => AlertDialog(
          title: const Text('Edit Task',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: editAndInsertAlertDialogContent(
            // statusController: statusCont,
            // formKey: formKey,
            context: context,
            dateController: dateController,
            detailsController: detailsController,
            timeController: timeController,
            titleController: titleController,
          ),
          actions: alertActions(
              onPressed: () {
                final isValid = formKey.currentState?.validate();
                bool isSameTable =
                    statusController == task['status'] ? true : false;
                // if (isSameTable) print('sametableee');
                if (isValid!) {
                  databaseController.updateDataToDB(
                    isSameTable: isSameTable,
                    oldStatus: task['status'],
                    title: titleController.text,
                    id: task['id'],
                    date: dateController.text,
                    time: timeController.text,
                    status: statusController,
                    details: detailsController.text,
                  );
                  Get.back();
                  toaster('Task updated successfully');
                }
              },
              confirmText: 'Ok',
              titleController: titleController,
              dateController: dateController,
              timeController: timeController,
              detailsController: detailsController,
              context: context),
        ),
      );
    },
  );
}

Future<void> showInsertDialog(context) async {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  statusController = 'new';

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return GetBuilder<DatabaseController>(
        init: DatabaseController(),
        builder: (databaseController) => AlertDialog(
          title: const Text('Add Task',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: editAndInsertAlertDialogContent(
            // statusController: statusCont,
            // formKey: formKey,
            context: context,
            dateController: dateController,
            detailsController: detailsController,
            timeController: timeController,
            titleController: titleController,
          ),
          actions: alertActions(
              onPressed: () {
                final isValid = formKey.currentState?.validate();
                if (isValid!) {
                  databaseController.insertDatabase(
                    title: titleController.text,
                    date: dateController.text,
                    time: timeController.text,
                    status: statusController,
                    details: detailsController.text,
                  );
                  databaseController.getDataFromDB(databaseController.db);

                  Get.back();
                  toaster('Task added successfully');
                }
              },
              confirmText: 'Ok',
              titleController: titleController,
              dateController: dateController,
              timeController: timeController,
              detailsController: detailsController,
              context: context),
        ),
      );
    },
  );
}

Future<void> showTaskDialog(context, Map task) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(task['title'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              dateTimeRow(task: task),
              const SizedBox(
                height: 15,
              ),
              task['details'] != ''
                  ? Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          const Text(
                            'Details',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            task['details'],
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      );
    },
  );
}
