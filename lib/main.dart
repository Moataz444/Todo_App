import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/controllers/Theme_Controller.dart';
import 'package:todo_app/shared/styles/colors.dart';
import 'layout/todo_tasks_layout.dart';

main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        init: ThemeController(),
        builder: (val) => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                  primarySwatch: clr as MaterialColor,
                  appBarTheme: AppBarTheme(
                    color: clr,
                  )),
              home: const TodoTasks(),
            ));
  }
}
