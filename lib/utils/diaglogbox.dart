import 'package:chatbotapp/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dialog_controller.dart';

class DialogBox extends StatelessWidget {
  var controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AlertDialog(
        title: Center(child: Text('Create Group')),
        content: TextField(
          controller: controller.groupTextController.value,
          decoration: InputDecoration(
            hoverColor: Colors.pink,
            focusColor: Colors.pink,
            labelText: 'Group Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              print("Add Group Button Clicked");
              //add group  to  database
              controller.addGroup();

              Get.back();
            },
            child: Text('Add'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: controller.buttonColor.value,
            ),
          ),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              )),
        ],
      );
    });
  }
}
