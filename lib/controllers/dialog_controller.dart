import 'package:chatbotapp/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DialogController extends GetxController {
  TextEditingController textController = TextEditingController();

  Rx<Color> buttonColor = Colors.pink.obs;

  void addItem() {
    String itemName = textController.text;
    print('Item added: $itemName');
    textController.clear();
    buttonColor.value = Colors.green;
  }

  addGroup() {}
}
