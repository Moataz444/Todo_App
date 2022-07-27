import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared/components/constants.dart';
import '../shared/styles/colors.dart';

class ThemeController extends GetxController {
  ThemeData getThemeData() {
    return ThemeData(
        brightness: isDark ? Brightness.dark : null,
        primarySwatch: clr as MaterialColor,
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(selectedItemColor: clr),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: clr,
        ),
        appBarTheme: AppBarTheme(
          color: clr,
        ));
  }

  bool changeDarkMode(value) {
    // value
    //     ? Get.changeTheme(ThemeData.dark())
    //     : Get.changeTheme(ThemeData.light());
    // Get.changeTheme(ThemeData.fallback());
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
