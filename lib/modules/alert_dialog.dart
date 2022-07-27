import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class MyAlert extends StatelessWidget {
//   const MyAlert({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
//

Future<void> showMyDialog(context, Map task) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(task['title'],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(child: Text(task['details'])),
        actions: <Widget>[
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
                  child: const Text('Edit'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
