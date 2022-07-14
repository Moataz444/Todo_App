import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/Theme_Controller.dart';
import 'package:todo_app/shared/styles/colors.dart';
import '../shared/components/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void popupButtonSelected(String value) {}
  // final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
        // init: ThemeController(),
        builder: (themeController) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Scaffold(
                body: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Dark mode',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        Switch(
                          value: isDark,
                          onChanged: (value) {
                            themeController.changeDarkMode(value);
                          },
                          activeColor: clr,
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        const Text('Themes',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                              start: 7, end: 7),
                          width: 190,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: clr, width: 4)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(15),
                              isExpanded: true,
                              iconSize: 35,
                              value: dropdownValue,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 20,
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Blue Theme',
                                  child: Text('Blue Theme'),
                                ),
                                DropdownMenuItem(
                                  value: 'Red Theme',
                                  child: Text('Red Theme'),
                                ),
                                DropdownMenuItem(
                                  value: 'Pink Theme',
                                  child: Text('Pink Theme'),
                                ),
                                DropdownMenuItem(
                                  value: 'Green Theme',
                                  child: Text('Green Theme'),
                                ),
                              ],
                              onChanged: (theme) {
                                themeController.changeTheme(theme);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
