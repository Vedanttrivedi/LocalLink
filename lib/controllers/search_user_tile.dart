import 'package:chatbotapp/services/database_service.dart';
import 'package:chatbotapp/views/group_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTileController extends GetxController {
  RxBool isJoined = false.obs;
  addRemoveUserFromGroup(String userName, String userId, String groupId,
      String groupName, String admin) async {
    await DatabaseService(currentUserid: userId)
        .addUserInGroup(userName, userId, groupId, groupName, admin);

    if (isJoined.value == false) {
      //user joined the group show success msg and move user to that chat screen

      Get.bottomSheet(Container(
        height: 50,
        color: Colors.greenAccent,
        child: Row(
          children: [
            Text(
              "Joined " + groupName.toString(),
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            TextButton(
                onPressed: () {
                  Get.to(() => GroupChatPage(
                        groupId: groupId,
                        groupName: groupName,
                      ));
                },
                child: Text("ok"))
          ],
        ),
      ));
    } else {
      Get.bottomSheet(Container(
        height: 50,
        color: Colors.red,
        child: Row(
          children: [
            Center(
              child: Text(
                "Left " + groupName.toString(),
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text("ok"))
          ],
        ),
      ));
      isJoined.value = !isJoined.value;
    }
  }
}
