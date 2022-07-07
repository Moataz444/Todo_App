import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/components/constants.dart';
import '../shared/styles/colors.dart';

class ThemeController extends GetxController {
  bool changeDarkMode(value) {
    value
        ? Get.changeTheme(ThemeData.dark())
        : Get.changeTheme(ThemeData.light());

    isDark = !isDark;
    box.write('isDark', isDark);
    update();
    return isDark;
  }

  String changeTheme(var theme) {
    {
      switch (theme) {
        case ('Dark Theme'):
          break;
        case ('Blue Theme'):
          clr = blue;
          break;
        case ('Red Theme'):
          clr = red;
          break;
        case ('Pink Theme'):
          clr = pink;
          break;
        case ('Green Theme'):
          clr = green;
          break;
      }
      dropdownValue = theme.toString();
      box.write('dropdownValue', dropdownValue);
      box.write('clr', clr);
      update();
      return dropdownValue;
    }
  }
}
