import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/database_controller.dart';
import 'constants.dart';

String statusController = 'new';
final formKey = GlobalKey<FormState>();

Widget editAndInsertAlertDialogContent(
        {
        // required String statusController,
        required TextEditingController titleController,
        required TextEditingController dateController,
        required TextEditingController timeController,
        required TextEditingController detailsController,
        // required GlobalKey formKey,
        required context}) =>
    GetBuilder<DatabaseController>(
      init: DatabaseController(),
      builder: (databaseController) => SingleChildScrollView(
          child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(children: [
              const Text(
                'Status',
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsetsDirectional.only(start: 7, end: 7),
                // width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // border: Border.all(color: clr, width: 4),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // elevation: 160,
                    borderRadius: BorderRadius.circular(15),
                    // isExpanded: true,
                    iconSize: 35,
                    value: statusController,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      // fontSize: 20,
                    ),

                    items: const [
                      DropdownMenuItem(
                        value: 'new',
                        child: Text('new'),
                      ),
                      DropdownMenuItem(
                        value: 'done',
                        child: Text('done'),
                      ),
                      DropdownMenuItem(
                        value: 'archived',
                        child: Text('archived'),
                      ),
                    ],
                    onChanged: (value) {
                      // setState(() {});
                      statusController = value.toString();
                      databaseController.update();
                    },
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              // maxLines: 5,
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'title',
                // hintText: 'tttitttlt',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please write a title';
                }
                return null;
              },
              // onChanged: (value) {
              //   setState(() {
              //   });
              //   titleController.text = value.toString();
              // },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: dateController,
              // keyboardType:  TextInputType.none,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'date',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please select date';
                }
                return null;
              },
              onTap: () {
                // setState(() {
                // });
                showDatePicker(
                  context: context,

                  initialDate:
                      dateController.text == null || dateController.text == ''
                          ? DateTime.now()
                          : DateFormat('MMMM d, y', 'en_US')
                              .parse(dateController.text),
                  // DateTime.parse(dateController.text),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2500),
                  // DateTime.parse('2023-06-20'),
                ).then((value) {
                  return dateController.text = value.toString() == 'null'
                      ? DateFormat.yMMMMd().format(DateTime.now())
                      // .toString()
                      : DateFormat.yMMMMd().format(value!);

                  // dateController.text =
                  //     DateFormat.yMMMd().format(value);
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: timeController,
              // keyboardType: TextInputType.none,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'time',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please select time';
                }
                return null;
              },
              onTap: () {
                showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                ).then((value) {
                  // print(dateController.text);
                  return timeController.text = value!.format(context);
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: detailsController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'details',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      )),
    );

List<Widget> alertActions(
        {
        // required String statusController,
        // required GlobalKey formKey,
        required Function() onPressed,
        required String confirmText,
        required TextEditingController titleController,
        required TextEditingController dateController,
        required TextEditingController timeController,
        required TextEditingController detailsController,
        required context}) =>
    <Widget>[
      Row(
        children: [
          Expanded(
            child: TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          const Spacer(),
          Expanded(
            child: TextButton(
              onPressed: onPressed,
              child: Text(confirmText),
            ),
          ),
        ],
      ),
    ];
