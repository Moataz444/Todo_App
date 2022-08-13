import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/database_controller.dart';
import 'package:todo_app/modules/alert_dialog.dart';
import 'package:todo_app/shared/styles/colors.dart';

var dbController = Get.put(DatabaseController());
// FToast toast = FToast();
toaster(String msg) {
  // toast.removeQueuedCustomToasts();
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
      msg: msg,
// toastLength: Toast.LENGTH_SHORT,
// gravity: ToastGravity.CENTER,
// timeInSecForIosWeb: 1,
      backgroundColor: clr.withOpacity(0.95),
      textColor: Colors.white,
      fontSize: 16.0);
}

Widget addTaskButton({required context}) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        onTap: () => showInsertDialog(context),
        child: SizedBox(
          width: 80,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              'Add',
              style: TextStyle(fontSize: 20),
            ),
            Icon(Icons.add)
          ]),
        ),
      ),
    );

Widget dateTimeRow({required Map task}) => Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: clr,
          ),
          child: Text(
            '${task['date']}',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: clr,
          ),
          child: Text(
            '${task['time']}',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );

Widget buildTaskItem(Map task, context, int index) => Dismissible(
      key: Key(task['id'].toString()),
      background: Container(
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.centerRight,
        color: red,
        child:
            // IconButton(
            //   onPressed: () {
            //     // AppCubit.get(context).updateData(
            //     //   status: 'archive',
            //     //   id: model['id'],
            //     // );
            //   },
            Icon(
          Icons.delete_forever,
          color: Colors.white.withOpacity(0.9),
          size: 50,
          // ),
        ),
      ),
      // secondarybackground: Container(
      //   padding: const EdgeInsets.all(20.0),
      //   alignment: Alignment.centerLeft,
      //   color: green,
      //   child: const Icon(
      //     Icons.archive,
      //     color: Colors.black45,
      //     size: 50,
      //   ),
      // ),
      direction: DismissDirection.endToStart,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => showTaskDialog(context, task),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      child: Text(
                        '${++index}',
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${task['title']}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          dateTimeRow(task: task),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                // AppCubit.get(context).updateData(
                //   status: 'done',
                //   id: model['id'],
                // );
                showEditDialog(context, task);
              },
              icon: const Icon(
                Icons.edit,
                // color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        ongoingTasks.remove(task);
        dbController.deleteFromDB(id: task['id'], status: task['status']);
        dbController.getDataFromDB(dbController.db);
        toaster('Task deleted successfully');
      },
    );

Widget taskBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) {
          int index = newIndex > oldIndex ? --newIndex : newIndex;
          // var task = tasks[index];
          // tasks.remove(tasks[oldIndex]);
          // tasks.insert(index, task);
          // print(oldIndex);
          // print(index);

          dbController.updateDataToDB(
              id: tasks[index]['id'],
              title: tasks[oldIndex]['title'],
              date: tasks[oldIndex]['date'],
              time: tasks[oldIndex]['time'],
              status: tasks[oldIndex]['status'],
              details: tasks[oldIndex]['details']);

          // dbController.updateDataToDB(
          //     id: tasks[oldIndex]['id'],
          //     title: task['title'],
          //     date: task['date'],
          //     time: task['time'],
          //     status: task['status'],
          //     details: task['details']);

          if (oldIndex > newIndex) {
            for (int ind = newIndex; ind < oldIndex; ind++) {
              dbController.updateDataToDB(
                  id: tasks[ind + 1]['id'],
                  title: tasks[ind]['title'],
                  date: tasks[ind]['date'],
                  time: tasks[ind]['time'],
                  status: tasks[ind]['status'],
                  details: tasks[ind]['details']);
            }
          } else {
            for (int ind = oldIndex; ind < newIndex; ind++) {
              dbController.updateDataToDB(
                  id: tasks[ind]['id'],
                  title: tasks[ind + 1]['title'],
                  date: tasks[ind + 1]['date'],
                  time: tasks[ind + 1]['time'],
                  status: tasks[ind + 1]['status'],
                  details: tasks[ind + 1]['details']);
              // print(ind);
            }
          }
          dbController.getDataFromDB(dbController.db);

          // print(task);
          // print(tasks.length);
        },
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context, index);
        },
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
