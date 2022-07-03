import 'package:flutter/material.dart';
import 'package:todo_app/shared/styles/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void popupButtonSelected(String value) {}
  String dropdownValue = 'Blue Theme';
  Color color = clr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const Text('Themes',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
          const SizedBox(
            width: 10,
          ),
          DropdownButton<String>(
            value: dropdownValue,
            style: const TextStyle(color: Colors.black, fontSize: 20),
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
            onChanged: (value) {
              switch (value) {
                case ('Blue Theme'):
                  color = blue;
                  break;
                case ('Red Theme'):
                  color = red;
                  break;
                case ('Pink Theme'):
                  color = pink;
                  break;
                case ('Green Theme'):
                  color = green;
                  break;
              }
              setState(() {
                dropdownValue = value.toString();
                clr = color;
              });
            },
          ),
        ],
      ),
    );
  }
}
