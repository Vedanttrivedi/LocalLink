import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/group_chat_controller.dart';
import '../controllers/home_controller.dart';
import 'group_info.dart';
import 'message_page.dart';

class GroupChatPage extends StatelessWidget {
  final String? groupName;
  final String? groupId;
  const GroupChatPage({super.key, this.groupName, this.groupId});

  @override
  Widget build(BuildContext context) {
    var userController = Get.find<HomeController>();
    var controller = Get.put(GroupChatController(groupId!));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.orange),
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            groupName!.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.pinkAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //move to another page which shows group info
              Get.to(GroupInfo(groupId: groupId!));
            },
            icon: const Icon(Icons.info_rounded),
            color: Colors.white,
          ),
          const SizedBox(width: 20),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 1, 8, 11), // Dark background color
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.messages.value.isEmpty) {
                      return const Center(
                        child: Text(
                          "Start the Conversation",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: controller.messages.value.length,
                        itemBuilder: (context, index) {
                          return MessageWidget(
                            controller.messages.value[index].sender,
                            controller.messages.value[index].message,
                            controller.messages.value[index].sender ==
                                userController.user.value.fullname,
                            controller.messages.value[index].time,
                          );
                        },
                      );
                    }
                  }),
                ),
                SizedBox(height: 80),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: Get.width,
              child: Container(
                padding: EdgeInsets.all(15),
                color: Colors.black, // Send message bar color
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.msgField.value,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Send",
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(
                              255, 167, 29, 167), // Textfield background color
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          print("button press");
                          controller.send(
                            groupId!,
                            userController.user.value.fullname!,
                            userController.user.value.uid!,
                          );
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 25,
                        ),
                        // Adding more styles to the IconButton
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        enableFeedback: true,
                        tooltip: 'Send Message',
                        splashRadius: 22,
                        constraints: BoxConstraints(
                          maxWidth: 40,
                          maxHeight: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
