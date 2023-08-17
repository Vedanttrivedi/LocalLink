import 'package:chatbotapp/helper/helper_function.dart';
import 'package:chatbotapp/models/show_chats_models.dart';
import 'package:chatbotapp/services/auth_service.dart';
import 'package:chatbotapp/services/database_service.dart';
import 'package:chatbotapp/services/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class HomeController extends GetxController {
  AuthController authController = AuthController.instance;
  Rx<CustomUser> user = CustomUser().obs;
  Rx<TextEditingController> groupTextController = TextEditingController().obs;
  Rx<Color> buttonColor = Colors.pink.obs;
  Rx<List<String>> chatList = Rx<List<String>>([]);
  Rx<List<Map<String, String>>> chats = Rx<List<Map<String, String>>>([]);
  var bottomBarIndex = 0.obs;
  @override
  Future<void> onInit() async {
    await HelperFunction.getUserName().then((value) {
      user.value.fullname = value;
    });
    await HelperFunction.getEmail().then((value) {
      user.value.email = value;
    });
    user.value.uid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot snapshot =
        await DatabaseService(currentUserid: user.value.uid)
            .getUserDetails(user.value.email);

    chatList.bindStream(FirebaseFirestore.instance
        .collection("users")
        .doc(user.value.uid)
        .snapshots()
        .map((event) {
      return event.get("groups").cast<String>();
    }));
    super.onInit();
  }

  addGroup() async {
    if (user.value.fullname == null) {
      await HelperFunction.getUserName()
          .then((value) => user.value.fullname = value);
    }
    //await DatabaseService(currentUserid: user.value.uid)
    //  .createGroup(user.value.fullname, groupTextController.value.text);
    QuerySnapshot snapshot =
        await DatabaseService(currentUserid: user.value.uid)
            .getUserDetails(user.value.email);
    user.value.groups = snapshot.docs[0].get("groups");
    groupTextController.value.clear();
  }
}
