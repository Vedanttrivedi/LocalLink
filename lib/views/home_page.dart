import 'package:chatbotapp/services/auth_service.dart';
import 'package:chatbotapp/services/notification_service.dart';
import 'package:chatbotapp/utils/diaglogbox.dart';
import 'package:chatbotapp/views/CreateGroup.dart';
import 'package:chatbotapp/views/my_group_views.dart';
import 'package:chatbotapp/views/search_group.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  void init() {}
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    NotificationServices services = NotificationServices();
    services.requestNotificationPermission();
    services.firebaseInit(context);
    if (kDebugMode) {
      print("debug mode");
      services.getDeviceToken().then((value) => print(value));
    }
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
              child: Text(
            "LocalLink",
            style: TextStyle(color: Colors.orange, fontSize: 25),
          )),
        ),
        backgroundColor: Color.fromARGB(0, 41, 3, 3),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              onTap: (index) {
                controller.bottomBarIndex.value = index;
                //redirect the user based on condition
                if (controller.bottomBarIndex == 0) {
                  //chat home page
                } else if (controller.bottomBarIndex == 1) {
                  /* showDialog(
                      context: context,
                      builder: (context) {
                        return DialogBox();
                      });*/
                  Get.to(MyForm(controller.user.value.uid,
                      controller.user.value.fullname));
                  controller.bottomBarIndex.value = 0;
                  //create group
                } else if (controller.bottomBarIndex == 2) {
                  //location groups
                } else if (controller.bottomBarIndex == 3) {
                  Get.to(SearchGroup(controller.user.value.fullname,
                      controller.user.value.uid));
                  controller.bottomBarIndex.value = 0;
                  //search groups
                } else {
                  //user profile page
                  controller.authController.logout();
                  controller.bottomBarIndex.value = 0;
                }
              },
              currentIndex: controller.bottomBarIndex.value,
              backgroundColor: Colors.black,
              items: [
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.chat,
                      color: Colors.orange,
                    ),
                    icon: Icon(
                      Icons.chat,
                    ),
                    label: "home",
                    backgroundColor: Colors.black),
                BottomNavigationBarItem(
                    activeIcon: Icon(
                      Icons.add,
                      color: Colors.orange,
                    ),
                    backgroundColor: Colors.black,
                    icon: Icon(
                      Icons.add,
                    ),
                    label: "Create"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    activeIcon: Icon(
                      Icons.location_searching,
                      color: Colors.orange,
                    ),
                    icon: Icon(Icons.location_searching),
                    label: "Chat"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    activeIcon: Icon(
                      Icons.search,
                      color: Colors.orange,
                    ),
                    icon: Icon(Icons.search),
                    label: "Search"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    activeIcon: Icon(
                      Icons.account_circle,
                      color: Colors.orange,
                    ),
                    icon: Icon(Icons.account_circle),
                    label: "Profile"),
              ]),
        ),
        body: Container(child: Center(child: Obx(() {
          print("in the widget ");

          if (controller.chatList.value.isEmpty) {
            //if no groups found
            return const Text(
              "No Groups Found!",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            );
          } else {
            //if groups found show list
            int totalGroups = controller.chatList.value.length - 1;
            return ListView.builder(
                itemCount: controller.chatList.value.length,
                itemBuilder: (context, index) {
                  return MyGroupList(
                    lastMessage: controller.chatList.value[totalGroups - index],
                    groupId: getGroupId(
                        controller.chatList.value[totalGroups - index]),
                    groupName: getGroupName(
                        controller.chatList.value[totalGroups - index]),
                    activity: controller.chatList.value[totalGroups - index],
                  );
                });
          }
        }))),
      ),
    );
  }
}

getGroupName(String str) {
  return str.substring(str.indexOf("_") + 1, str.length);
}

getGroupId(String str) {
  return str.substring(0, str.indexOf("_"));
}
