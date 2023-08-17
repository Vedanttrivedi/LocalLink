import 'package:chatbotapp/controllers/search_controller.dart';
import 'package:chatbotapp/views/search_group_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchGroup extends StatelessWidget {
  final String? userid;
  final String? username;

  SearchGroup(this.username, this.userid);

  @override
  Widget build(BuildContext context) {
    bool currentState = false;
    var controller = Get.put(MySearchController());

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black, // Dark app bar background color
        title: Text('Find New Groups',
            style: TextStyle(color: Colors.orange)), // White app bar text color
        centerTitle: true,
        elevation: 0, // No shadow for the app bar
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchField.value,
              onChanged: (val) {
                controller.fetchGroupByName(val);
                if (val.isEmpty) {
                  controller.searchList.value = [];
                }
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search,
                    color: Colors.white), // White search icon color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.grey, // Dark search box background color
                hintStyle:
                    TextStyle(color: Colors.white70), // White hint text color
              ),
              style: TextStyle(
                  color: Colors.white), // White text color for input text
            ),
          ),
          Obx(() {
            if (controller.searchList.value.isEmpty) {
              return Text(
                "No Groups Found!",
                style: TextStyle(fontSize: 18, color: Colors.white),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.searchList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    currentState = listContainsString(
                        controller.searchList.value[index].members!, username!);

                    return UserListTile(
                      groupId: controller.searchList.value[index].groupId,
                      userId: userid,
                      username: username,
                      groupName:
                          controller.searchList.value[index].groupName ?? "",
                      members:
                          controller.searchList.value[index].members!.length ??
                              0,
                      isJoined: currentState,
                      admin: controller.searchList.value[index].admin!,
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
      backgroundColor: Colors.black, // Dark background color
    );
  }
}

bool listContainsString(List<dynamic> list, String string) {
  for (var item in list) {
    var lists = item.toString().split("_");

    if (lists[1] == string) {
      return true;
    }
  }
  return false;
}
