import 'package:chatbotapp/controllers/search_user_tile.dart';
import 'package:chatbotapp/views/group_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListTile extends StatelessWidget {
  final int? members;
  final String? groupName;
  final bool? isJoined;
  final String? username;
  final String? userId;
  final String? groupId;
  final String? admin;
  const UserListTile({
    Key? key,
    this.members,
    this.groupName,
    this.isJoined,
    this.groupId,
    this.username,
    this.userId,
    this.admin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(UserTileController());
    controller.isJoined.value = isJoined!;

    Color buttonColor =
        controller.isJoined.value! ? Colors.deepPurpleAccent : Colors.orange;
    Color textColor = controller.isJoined.value! ? Colors.black : Colors.white;

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepPurpleAccent, // Adjusted the tile background color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        trailing: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: buttonColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 2,
          ),
          onPressed: () {
            controller.addRemoveUserFromGroup(
              username!,
              userId!,
              groupId!,
              groupName!,
              admin!,
            );
          },
          child: Text(
            controller.isJoined.value! ? "Leave" : "Join",
            style: TextStyle(
              fontSize: 20,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          // Add any specific behavior when the tile is tapped.
        },
        leading: CircleAvatar(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          child: Text(
            groupName!.substring(0, 1),
            style: TextStyle(fontSize: 20),
          ),
        ),
        title: Text(
          groupName!,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Container(
          margin: EdgeInsets.all(5),
          child: Text(
            members!.toString() + " members",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
