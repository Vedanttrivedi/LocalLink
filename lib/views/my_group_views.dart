import 'package:chatbotapp/views/group_chat_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyGroupList extends StatelessWidget {
  final String? groupId;
  final String? groupName;
  final String? lastMessage;
  final String? activity;

  const MyGroupList(
      {super.key,
      this.groupId,
      this.groupName,
      this.lastMessage,
      this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 49, 17, 97)),
      child: ListTile(
        onTap: () {
          Get.to(() => GroupChatPage(groupId: groupId, groupName: groupName));
        },
        leading: CircleAvatar(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          child: Text(groupName!.substring(0, 1)),
        ),
        title: Text(
          groupName!,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          (lastMessage == null) ? activity! : lastMessage!,
          style: TextStyle(fontSize: 15, color: Colors.amberAccent),
        ),
      ),
    );
  }
}
