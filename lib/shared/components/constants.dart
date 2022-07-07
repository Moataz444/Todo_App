import 'package:get_storage/get_storage.dart';

bool isDark = box.read('isDark') ?? false;

String dropdownValue = box.read('dropdownValue') ?? 'Blue Theme';

GetStorage box = GetStorage('MyStorage');

void writeBox(String key, dynamic value) => box.write(key, value);
