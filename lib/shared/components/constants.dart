import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../modules/archived_tasks_screen.dart';
import '../../modules/done_tasks_screen.dart';
import '../../modules/ongoing_tasks_screen.dart';
import '../../modules/settings_screen.dart';

final List<Widget> screens = [
  const OngoingTasksScreen(),
  const DoneTasksScreen(),
  const ArchivedTasksScreen(),
  const SettingsScreen(),
];

final List<String> title = [
  'Ongoing Tasks',
  'Done Tasks',
  'Archived Tasks',
  'Settings',
];

bool isDark = box.read('isDark') ?? false;

String dropdownValue = box.read('dropdownValue') ?? 'Blue Theme';

GetStorage box = GetStorage('MyStorage');

void writeBox(String key, dynamic value) => box.write(key, value);
