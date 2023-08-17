import 'package:chatbotapp/models/show_chats_models.dart';
import 'package:chatbotapp/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';

class MySearchController extends GetxController {
  Rx<TextEditingController> searchField = TextEditingController().obs;
  RxList<ShowChat> searchList = <ShowChat>[].obs;
  List<ShowChat> allgroups = [];
  var result = [];
  @override
  void onInit() {
    super.onInit();

    DatabaseService().getByGroupNames().then((value) {
      allgroups = value;
    });
  }

  fetchGroupByName(String str) {
    searchList.value = allgroups.where((element) {
      return element.groupName != null &&
          element.groupName!
              .toString()
              .toLowerCase()
              .contains(str.toLowerCase());
    }).toList();
  }

  addUserInGroup(String userid, String groupid) async {}
}
